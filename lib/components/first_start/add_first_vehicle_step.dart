import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AddFirstVehicleStep extends StatelessWidget {
  final VoidCallback onNext;

  const AddFirstVehicleStep({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(title: Text('welcome.add_first_vehicle.title'.tr(args: ['TestApp™']), textAlign: TextAlign.center)),
        const Expanded(
          child: FlutterLogo(size: 128),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
