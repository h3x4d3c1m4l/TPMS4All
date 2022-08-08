// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:avatar_glow/avatar_glow.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Glow extends StatelessWidget {
  final double glowRadius;
  final Color? glowColor;
  final Widget child;
  final bool repeat;

  const Glow({
    super.key,
    required this.glowRadius,
    this.glowColor,
    required this.child,
    this.repeat = true,
  });

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: glowColor ?? Colors.transparent,
      animate: glowColor != null,
      endRadius: glowRadius,
      repeat: repeat,
      child: child,
    );
  }
}
