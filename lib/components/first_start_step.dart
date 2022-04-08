import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as ms;

class FirstStartStep extends StatelessWidget {
  final VoidCallback? onBack;

  const FirstStartStep({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (onBack != null)
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(
                ms.FluentIcons.arrow_left_16_regular,
                size: 24,
              ),
              onPressed: () => {},
            ),
          ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(34, onBack == null ? 40 : 0, 34, 34),
            child: Column(
              children: [
                PageHeader(title: Text('welcome.welcome.title'.tr(args: ['SuperApp™']), textAlign: TextAlign.center)),
                const Expanded(
                  child: FlutterLogo(size: 128),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('cancel'.tr()),
                      onPressed: () => {},
                    ),
                    const SizedBox(width: 20),
                    FilledButton(
                      child: Text('home.vehicle_card.configure'.tr()),
                      onPressed: () => {},
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
