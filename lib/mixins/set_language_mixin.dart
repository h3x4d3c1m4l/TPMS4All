import 'package:dart_extensions/dart_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:universal_tpms_reader/blocs/_all.dart';

mixin SetLanguageMixin<T extends StatefulWidget> on State<T> {
  late SettingsBloc settingsBloc;

  Future setAndStoreLanguage(String? languageCode) async {
    // save setting
    settingsBloc.add(SaveSettings(
      settingsBloc.state.settings.copyWith(languageCode: languageCode),
    ));

    // set UI
    if (languageCode != null) {
      // user picked an actual language option
      await context.setLocale(Locale(languageCode));
    } else {
      // user picked 'default' option (meaning: set to device language with fallback)

      // note: we should be able to use context.resetLocale() but
      // it force sets the locale to the first device preferred locale even if not supported
      // by us; this will make Flutter crash :(

      // check if we support any locales the user has set as preferred in their OS
      Locale? supportedLocale = WidgetsBinding.instance!.window.locales.firstOrNullWhere((deviceLocale) =>
          context.supportedLocales.any((supportedLocale) => supportedLocale.languageCode == deviceLocale.languageCode));

      if (supportedLocale != null) {
        await context.setLocale(Locale(supportedLocale.languageCode));
      } else {
        await context.setLocale(context.fallbackLocale!);
      }
    }
  }

  static List<ComboboxItem<String?>> getLanguageOptions() {
    return <ComboboxItem<String?>>[
      ComboboxItem<String>(child: Text('settings.settings.language.options.default'.tr()), value: null),
      ComboboxItem<String>(child: Text('settings.settings.language.options.english'.tr()), value: 'en'),
      ComboboxItem<String>(child: Text('settings.settings.language.options.dutch'.tr()), value: 'nl'),
    ].lock.unlockView;
  }
}
