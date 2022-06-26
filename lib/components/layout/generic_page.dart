// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fluent_ui/fluent_ui.dart';
import 'package:routemaster/routemaster.dart';

class GenericPage extends StatelessWidget {
  final String title;
  final Widget content;

  const GenericPage({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: ScaffoldPage(
        header: GestureDetector(
          onTap: () => Routemaster.of(context).history.back(),
          child: PageHeader(
            title: Text(title),
            leading: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(FluentIcons.chevron_left),
            ),
          ),
        ),
        content: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: content,
        ),
      ),
    );
  }
}
