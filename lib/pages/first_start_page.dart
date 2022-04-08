import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;
import 'package:universal_tpms_reader/components/_all.dart';
import 'package:universal_tpms_reader/mixins/set_language_mixin.dart';
import 'package:universal_tpms_reader/blocs/settings/settings_bloc.dart';
import 'package:universal_tpms_reader/models/application/_all.dart';

class FirstStartPage extends StatefulWidget {
  const FirstStartPage({Key? key}) : super(key: key);

  @override
  _FirstStartPage createState() => _FirstStartPage();
}

class _FirstStartPage extends State<FirstStartPage> with TickerProviderStateMixin, SetLanguageMixin {
  int _step = 0;
  final _languageFlyoutController = FlyoutController();

  @override
  void initState() {
    super.initState();
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = FluentTheme.of(context);
    return BlocSelector<SettingsBloc, SettingsState, Settings>(
      selector: (state) => state.settings,
      builder: (context, settings) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                themeData.accentColor.withAlpha(40),
                const Color(0xFFE8EAF6),
              ],
              center: const Alignment(-0.1, 0.9),
              radius: 0.5,
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
              gridArea('t').containing(
                Container(
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
                      totalSteps: 5,
                      currentStep: 2,
                      selectedColor: themeData.accentColor,
                    ),
                  ),
                ),
              ),
              gridArea('B').containing(
                Container(
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
                  child: FirstStartStep(onBack: () {}),
                ),
              ),
              gridArea('b').containing(Center(
                child: Row(children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InfoLabel(
                        label: 'welcome.language'.tr(),
                        child: Combobox<String?>(
                          placeholder: Text('settings.settings.language.options.default'.tr()),
                          isExpanded: true,
                          items: SetLanguageMixin.getLanguageOptions(),
                          value: settings.languageCode,
                          onChanged: (languageCode) {
                            setAndStoreLanguage(languageCode);
                          },
                        ),
                      ),
                    ),
                  ),

                  // language selector
                  Flyout(
                    controller: _languageFlyoutController,
                    placement: FlyoutPlacement.end,
                    content: (BuildContext context) {
                      return BlocSelector<SettingsBloc, SettingsState, String?>(
                        selector: (state) => state.settings.languageCode,
                        builder: (context, languageCode) {
                          List<ComboboxItem<String?>> options = SetLanguageMixin.getLanguageOptions();
                          return FlyoutContent(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(options.length, (index) {
                                return RadioButton(
                                  checked: options.indexWhere((o) => o.value == languageCode) == index,
                                  onChanged: (value) => setAndStoreLanguage(options[index].value),
                                  content: options[index].child,
                                );
                              }),
                            ),
                          );
                        },
                      );
                    },
                    child: IconButton(
                      icon: const Icon(FluentIcons.color, size: 24.0),
                      onPressed: () {
                        _languageFlyoutController.open();
                      },
                    ),
                  ),
                ]),
              )),
            ],
          ),
        );
      },
    );
  }
}
