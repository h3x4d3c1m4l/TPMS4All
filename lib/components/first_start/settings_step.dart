import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';

class SettingsStep extends StatelessWidget {
  final VoidCallback onNext;

  const SettingsStep({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(title: Text('welcome.settings.title'.tr(), textAlign: TextAlign.center)),
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
              onPressed: onNext,
              child: Text('next'.tr()),
            ),
          ],
        )
      ],
    );
  }
}
