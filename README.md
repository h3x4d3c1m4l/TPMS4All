# TPMS 4 All 🚗🏍️

Bluetooth tire pressure sensor reader for Android and iOS, built using [Flutter](https://flutter.dev/).

## Project goals

- Support different types of TPMS sensors
  - At the moment it supports the most common TPMS sensor that can be found on many electronics websites
- Support multiple vehicles
  - Any combination of cars, motorcycles, other vehicles (with 1..n amount of sensors on it)
- Nice UI (simple to use for everyone)
- Available for Android and iOS
  - iOS is untested at the moment due to not having access to macOS and iOS/iPadOS

## TODOs

- Find a way to detect Bluetooth version of the device
  - Some newer model sensors use the same protocol but only transmit packets using Bluetooth 5.0, thus devices with Bluetooth 4.x can't receive their advertisements
- Tire/Sensor detail view
  - This would allow to see more info on the sensor and swap and test the sensor
- Allow creating a (non car, non motorcycle) vehicle with 'n' tires
  - Tires should be able to be named for identification purpose
- Improve `FakeBle`, generate random sensor data values instead of static data
- Fix hamburger menu not closing after clicking on a Add Vehicle, Settings or About
- Warn when there are permissions issues

## Ideas

- Add support for more sensors
  - If you happen to have any which currently don't work, open an issue on GitHub and let me know!
- Add MQTT support for publishing sensor values
- Share a vehicle by QR-code, NFC
- First start wizard (permissions, settings)
  - Might reuse as well when permissions are removed (by user, or automatically by Android) to fix permissions

## Project stack

- Framework: [Flutter](https://flutter.dev/)
- Routing: [Routemaster](https://pub.dev/packages/routemaster)
- UI/UX kit: [Fluent UI](https://pub.dev/packages/fluent_ui)
- Icons: [Fluent UI System Icons](https://pub.dev/packages/fluentui_system_icons)
- Bluetooth interfacing: [Reactive BLE](https://pub.dev/packages/flutter_reactive_ble)
- State management: [Bloc](https://pub.dev/packages/flutter_bloc)
- Persistence: [Isar](https://pub.dev/packages/isar)
- Model immutability: [Freezed](https://pub.dev/packages/freezed), [Fast Immutable Collections](https://pub.dev/packages/fast_immutable_collections)
- l10n: [Easy Localization](https://pub.dev/packages/easy_localization)

## Running the project

This project uses the great [`fvm`](https://fvm.app/) to ease Flutter version selection, upgrading and CI/CD (in the future). If `fvm` is available in your path:

- Run `fvm install` from the project checkout directory to install the correct Flutter version
- Simply call the correct versions of `flutter` and `dart` by prefixing any below commands with `fvm`
- You can change the Flutter/Dark SDK versions by running `fvm use <version>` (e.g. `fvm use 2.10.4`) and restart your IDE (if applicable)

Note: The project itself does not depend on fvm, it just makes my life a little easier.

Make sure to run the appropriate Flutter version (please see [the fvm config file](.fvm/fvm_config.json) for the version number) by installing it manually or using fvm. After code checkout, run `flutter pub get` then `flutter pub run build_runner build` for code generation. If all steps have succeeded you can simply run the project from your favoriete IDE on an emulator or physical device.

If you're testing on a emulator, you might want to uncomment the line in [`bluetooth_bloc.dart`](lib/blocs/bluetooth/bluetooth_bloc.dart) that creates an instance of `ReactiveBle` and uncomment the line that creates an instance of `FakeBle`. Be sure to not commit the change. Doing this will generate fake Bluetooth TPMS sensor data for testing, as the Android emulator currently does not support emulating Bluetooth devices.

## Code quality

- This project uses `flutter_lints`
  - No warnings allowed, verify by running `flutter analyze` before committing
- Additional guidelines:
  - Use max line length of 120
  - Split long pieces of code using functions or at least by comments
    - This makes it easy to quickly 'scan' through code
  - Make use of `// TODO` but also `// Could Have` for 'nice to have functionality'
  - Prefer Flutter Favorite packages and packages that are still being actively maintained for the past months
    - Doing this will make sure the app will run on newer Flutter releases with minimal fixes
  - Only use packages that support both Android and iOS/iPadOS
  - Keep the project up to date with the latest Flutter release and regularly run a `flutter pub outdated` to check for outdated dependencies
    - Be sure to check changelogs for any upgraded dependencies to make sure the upgrade won't cause unwanted side effects