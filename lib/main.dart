// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:routemaster/routemaster.dart';
import 'package:system_theme/system_theme.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';
import 'package:universal_tpms_reader/components/_all.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';
import 'package:universal_tpms_reader/pages/_all.dart';

final bool _systemUsesDarkMode = SystemTheme.isDarkMode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  GetIt.I.registerSingleton(await PackageInfo.fromPlatform());

  // divide initialization of app into pieces to keep the code simple:
  // FluentTheme: sets ThemeData according to system setting (this will be overriden when settings are loaded)
  // AppBlocProviderAndInitializer: creates, initializes and provides BLoCs
  // AppBlocInitializationAwaiter: show spinner while BLoCs are still initializing
  // AppEasyLocalization: initialize l10n
  runApp(
    FluentTheme(
      data: _systemUsesDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: const AppBlocProviderAndInitializer(
        child: AppBlocInitializationAwaiter(
          child: AppEasyLocalization(
            child: App(),
          ),
        ),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothBloc, BluetoothState>(
      builder: (context, bluetoothState) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) => FluentApp.router(
            // TODO: this looks good on Android 11, check on 12 and older, also check on iOS/iPadOS
            builder: (context, child) => Container(
              color: FluentTheme.of(context).micaBackgroundColor,
              child: SafeArea(child: child!),
            ),
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                return RouteMap(
                  routes: {
                    '/': (routeData) {
                      if (_shouldShowFirstStartPage(settingsState.settings, bluetoothState)) {
                        return const Redirect('/first_start');
                      }
                      return const Redirect('/dashboard');
                    },
                    '/about': (routeData) => const FluentPage(key: ValueKey('about'), child: AboutPage()),
                    '/first_start': (routeData) =>
                        const FluentPage(key: ValueKey('first_start'), child: FirstStartPage()),
                    '/dashboard': (routeData) => const FluentPage(key: ValueKey('dashboard'), child: HomePage()),
                    '/settings': (routeData) => const FluentPage(key: ValueKey('settings'), child: SettingsPage()),
                  },
                );
              },
            ),
            routeInformationParser: const RoutemasterParser(),
            color: Colors.blue,
            theme: _getThemeData(settingsState.settings.appTheme),
            debugShowCheckedModeBanner: false,

            // easy_localization
            localizationsDelegates: [...context.localizationDelegates, const TemporaryFluentLocalizationDelegate()],
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        );
      },
    );
  }

  ThemeData _getThemeData(AppTheme appTheme) {
    switch (appTheme) {
      case AppTheme.byDevice:
        return _systemUsesDarkMode ? ThemeData.dark() : ThemeData.light();
      case AppTheme.light:
        return ThemeData.light();
      case AppTheme.dark:
        return ThemeData.dark();
    }
  }

  bool _shouldShowFirstStartPage(Settings settings, BluetoothState bluetoothState) {
    final PackageInfo packageInfo = GetIt.I<PackageInfo>();
    if (packageInfo.version != settings.firstStartVersion ||
        !settings.firstStartKeys.unorderedEqualItems(FirstStartPage.knownFirstStartKeys) ||
        !bluetoothState.bluetoothPermissionsGranted) {
      return true;
    }
    return false;
  }
}
