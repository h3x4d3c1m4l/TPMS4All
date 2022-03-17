// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fluent_ui/fluent_ui.dart';

/// Temporary hack to make the app not crash, as Fluent UI only supports English at the moment.
/// This hack should be removed when Fluent UI gains multilangual support.
class TemporaryFluentLocalizationDelegate
    extends LocalizationsDelegate<FluentLocalizations> {
  const TemporaryFluentLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<FluentLocalizations> load(Locale locale) =>
      DefaultFluentLocalizations.load(locale);

  @override
  bool shouldReload(TemporaryFluentLocalizationDelegate old) => false;

  @override
  String toString() => 'EasyLocalizationFluentLocalizationDelegate';
}
