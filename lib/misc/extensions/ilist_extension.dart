// Copyright 2022 Sander in 't Hout.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

extension IListExtension<T> on IList<T> {
  IList<T> upsert(bool Function(T item) selectorCallback, T upsertItem) {
    for (int i = 0; i < length; i++) {
      if (selectorCallback(this[i])) {
        return replace(i, upsertItem);
      }
    }
    return add(upsertItem);
  }

  IList<T> mutate(bool Function(T item) mutateItemSelectorCallback, T Function(T item) mutateCallback) {
    for (int i = 0; i < length; i++) {
      if (mutateItemSelectorCallback(this[i])) {
        return replace(i, mutateCallback(this[i]));
      }
    }
    return this;
  }
}
