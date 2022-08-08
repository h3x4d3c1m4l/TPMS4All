// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LedIndicator extends StatelessWidget {
  final LedColor? color;
  final double? size;

  const LedIndicator({super.key, required this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/${getAssetFilename()}',
      height: size,
      width: size,
    );
  }

  String getAssetFilename() {
    switch (color) {
      case LedColor.red:
        return 'led_red.svg';
      case LedColor.green:
        return 'led_green.svg';
      case LedColor.orange:
        return 'led_orange.svg';
      default:
        return 'led_off.svg';
    }
  }
}

enum LedColor {
  off,
  red,
  green,
  orange,
}
