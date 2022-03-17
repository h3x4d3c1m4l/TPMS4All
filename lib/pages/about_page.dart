// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:universal_tpms_reader/components/_all.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return GenericPage(
      title: 'about.title'.tr(),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TODO: replace by own logo
            const FlutterLogo(size: 60),
            const SizedBox(height: 10),
            const Text("TPMS for All", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: AboutAction(
                    caption: 'GitHub',
                    icon: FluentIcons.code,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: AboutAction(
                    caption: 'Store',
                    icon: FluentIcons.store_logo16,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text("Written by:\r\nSander (h3x4d3c1m4l) in 't Hout", textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
