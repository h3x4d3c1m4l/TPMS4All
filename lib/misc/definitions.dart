// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

typedef Event = void Function();

Uint8List hexToUint8List(String hex) {
  if (hex.length % 2 != 0) {
    throw 'Odd number of hex digits';
  }
  final l = hex.length ~/ 2;
  final result = Uint8List(l);
  for (var i = 0; i < l; ++i) {
    final x = int.parse(hex.substring(i * 2, 2 * (i + 1)), radix: 16);
    if (x.isNaN) {
      throw 'Expected hex string';
    }
    result[i] = x;
  }
  return result;
}
