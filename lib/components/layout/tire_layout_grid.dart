// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

/// Inspired by: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class TireLayoutGrid extends StatelessWidget {
  const TireLayoutGrid({
    Key? key,
    required this.crossAxisCount,
    required this.children,
  })  
  // we only plan to use this with 1 or 2 columns
  : assert(crossAxisCount == 1 || crossAxisCount == 2),
    super(key: key);
  final int crossAxisCount;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      // set some flexible track sizes based on the crossAxisCount
      columnSizes: crossAxisCount == 2 ? [1.fr, 1.fr] : [1.fr],
      // set all the row sizes to auto (self-sizing height)
      rowSizes: crossAxisCount == 2
          ? const [auto, auto]
          : const [auto, auto, auto, auto],
      rowGap: 45,
      columnGap: 45,
      children: children,
    );
  }
}