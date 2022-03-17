// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fluent_ui/fluent_ui.dart';

class AboutAction extends StatelessWidget {
  final IconData icon;
  final String caption;
  final Function() onPressed;

  const AboutAction({
    Key? key,
    required this.icon,
    required this.caption,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Column(
        children: [
          Icon(icon, size: 25),
          const SizedBox(height: 10),
          Text(caption),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
