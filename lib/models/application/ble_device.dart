// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:flutter/foundation.dart';

@immutable
class BleDevice {
  final Uint8List btAddress;
  final String name;
  final Uint8List vendorData;

  const BleDevice({
    required this.btAddress,
    required this.name,
    required this.vendorData,
  });
}