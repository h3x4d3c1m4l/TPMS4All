import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:universal_tpms_reader/blocs/settings/settings_bloc.dart';
import 'package:universal_tpms_reader/components/_all.dart';
import 'package:universal_tpms_reader/mixins/set_language_and_theme_mixin.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';

class FirstStartPage extends StatefulWidget {
  const FirstStartPage({Key? key}) : super(key: key);

  @override
  _FirstStartPage createState() => _FirstStartPage();
}

class _FirstStartPage extends State<FirstStartPage> with TickerProviderStateMixin, SetLanguageAndThemeMixin {
  final _languageFlyoutController = FlyoutController();
  final _themeFlyoutController = FlyoutController();
  late final List<Widget> _steps;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    settingsBloc = BlocProvider.of<SettingsBloc>(context);

    // determine steps
    _steps = [
      WelcomeStep(onNext: _next),
      SettingsStep(onNext: _next),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = FluentTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            themeData.accentColor.withAlpha(40),
            const Color(0xFFE8EAF6),
          ],
          center: const Alignment(-0.1, 0.9),
        ),
      ),
      child: LayoutGrid(
        columnGap: 12,
        rowGap: 12,
        areas: '''
            lt t rt
            l  B r
            lb b rb
          ''',
        // A number of extension methods are provided for concise track sizing
        columnSizes: [
          0.2.fr,
          5.0.fr,
          0.2.fr,
        ],
        rowSizes: [
          0.8.fr,
          5.0.fr,
          0.8.fr,
        ],
        children: [
          gridArea('t').containing(Builder(builder: _getTopWidget)),
          gridArea('B').containing(Builder(builder: _getCenterWidget)),
          gridArea('b').containing(Builder(builder: _getBottomWidget)),
        ],
      ),
    );
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _next() {
    if (_currentStep < (_steps.length - 1)) {
      setState(() => _currentStep++);
    }
  }

  Widget _getTopWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: StepProgressIndicator(
          customStep: (index, color, size) {
            return Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
          totalSteps: _steps.length,
          currentStep: _currentStep,
          selectedColor: FluentTheme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget _getCenterWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            blurRadius: 30.0,
            spreadRadius: 10.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          AnimatedOpacity(
            opacity: _currentStep != 0 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  ms.FluentIcons.arrow_left_16_regular,
                  size: 24,
                ),
                onPressed: _back,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(34, 0, 34, 34),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _steps[_currentStep],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBottomWidget(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, Settings>(
      selector: (state) => state.settings,
      builder: (context, settings) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // theme selector
              Flyout(
                controller: _themeFlyoutController,
                placement: FlyoutPlacement.end,
                content: (BuildContext context) {
                  final List<ComboboxItem<AppTheme>> options = SetLanguageAndThemeMixin.getAppThemeOptions();
                  return FlyoutContent(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(options.length, (index) {
                          return [
                            RadioButton(
                              checked: options.indexWhere((o) => o.value == settings.appTheme) == index,
                              onChanged: (value) {
                                applyAndStoreAppTheme(options[index].value!);
                                _themeFlyoutController.close();
                              },
                              content: options[index].child,
                            ),
                            if (index < (options.length - 1)) const SizedBox(height: 15),
                          ];
                        }).expand((l) => l).toList(),
                      ),
                    ),
                  );
                },
                child: IconButton(
                  icon: const Icon(FluentIcons.color, size: 24.0),
                  onPressed: _themeFlyoutController.open,
                ),
              ),

              // language selector
              Flyout(
                controller: _languageFlyoutController,
                placement: FlyoutPlacement.end,
                content: (BuildContext context) {
                  final List<ComboboxItem<String?>> options = SetLanguageAndThemeMixin.getLanguageOptions();
                  return FlyoutContent(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(options.length, (index) {
                          return [
                            RadioButton(
                              checked: options.indexWhere((o) => o.value == settings.languageCode) == index,
                              onChanged: (value) {
                                applyAndStoreLanguage(options[index].value);
                                _languageFlyoutController.close();
                              },
                              content: options[index].child,
                            ),
                            if (index != (options.length - 1)) const SizedBox(height: 15),
                          ];
                        }).expand((l) => l).toList(),
                      ),
                    ),
                  );
                },
                child: IconButton(
                  icon: const Icon(FluentIcons.locale_language, size: 24.0),
                  onPressed: _languageFlyoutController.open,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
