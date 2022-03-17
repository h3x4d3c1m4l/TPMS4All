// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fluent_ui/fluent_ui.dart';

/// Page that works like MaterialPage and CupertinoPage but for Fluent.
/// 
/// Note: This is used only as glue logic between Fluent UI and Routemaster to prevent dependency on Material.
class FluentPage<T> extends Page<T> {
  /// Creates a material page.
  const FluentPage({
    required this.child,
    this.maintainState = true,
    this.fullscreenDialog = false,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(key: key, name: name, arguments: arguments, restorationId: restorationId);

  /// The content to be shown in the [Route] created by this page.
  final Widget child;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  @override
  Route<T> createRoute(BuildContext context) {
    return FluentPageRoute<T>(
      builder: (context) => child,
      settings: this,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
    );
  }
}