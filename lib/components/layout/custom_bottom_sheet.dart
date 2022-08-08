// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fluent_ui/fluent_ui.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final String description;

  const CustomBottomSheet({
    super.key,
    required this.description,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.85,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BottomSheetTheme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (context, scrollController) => IconTheme.merge(
        data: IconThemeData(color: theme.handleColor),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: <Widget>[
                  BottomSheet.buildHandle(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: DefaultTextStyle(
                      style: FluentTheme.of(context).typography.caption!,
                      textAlign: TextAlign.center,
                      child: Text(description),
                    ),
                  ),
                  const Divider(
                    style: DividerThemeData(
                      horizontalMargin: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
