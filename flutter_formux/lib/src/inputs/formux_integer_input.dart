import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:formux/formux.dart';

typedef IntListFutureCallback = Future<IntList> Function()?;
typedef IntList = List<int>;

class FormuxIntegerInput extends FormuxInput<int?>
    with FormuxTranslations
    implements FormuxInputValueUpdater<int?> {
  FormuxIntegerInput({
    super.value,
    this.fetcher,
    this.minValue,
    this.maxValue,
    IntList? items,
  }) : items = items ?? [];

  FormuxIntegerInput.notRequired({
    super.value,
    this.fetcher,
    this.minValue,
    this.maxValue,
    IntList? items,
  }) : items = items ?? [],
       super(required: false);

  IntListFutureCallback? fetcher;
  int? maxValue, minValue;
  IntList items = [];

  int get intValue => value ?? 0;

  @override
  void validator() {
    assertion(value == null, translations.required);

    if (value != null && maxValue != maxValue) {
      assertion(intValue > maxValue!, translations.maxValue(maxValue!));
    }
  }

  @override
  void clear() {
    value = null;
    hideErrors();
  }

  @override
  String valueToString() {
    return value == null ? '' : value.toString();
  }

  /// Callback from event
  void event(IntegerInputEvent event) {
    final callback = switch (event) {
      IntegerInputSetValue() => () {
        value = event.value;
      },
      IntegerInputSetItems() => () {
        items = event.items;
      },
      IntegerInputSetFetchClear() => () {
        fetcher = event.fetch;
        value = null;
        hideErrors();
      },
      IntegerInputSetFetch() => () {
        fetcher = event.fetch;
        items = [];
        hideErrors();
      },
    };
    callback();
  }

  @override
  int? onValue(int? value) {
    // Min value
    if (value != null && minValue != null && value < minValue!) {
      return minValue!;
    }

    // Max value
    if (value != null && maxValue != null && value > maxValue!) {
      return maxValue!;
    }

    return value;
  }
}

sealed class IntegerInputEvent {
  static IntegerInputSetValue setValue(int value) =>
      IntegerInputSetValue(value: value);
  static IntegerInputSetItems setItems(IntList items) =>
      IntegerInputSetItems(items: items);
  static IntegerInputSetFetch setFetch(IntListFutureCallback fetch) =>
      IntegerInputSetFetch(fetch: fetch);
  static IntegerInputSetFetchClear setFetchClear(IntListFutureCallback fetch) =>
      IntegerInputSetFetchClear(fetch: fetch);
}

class IntegerInputSetValue extends IntegerInputEvent {
  IntegerInputSetValue({required this.value});

  final int value;
}

class IntegerInputSetItems extends IntegerInputEvent {
  IntegerInputSetItems({required this.items});

  final IntList items;
}

class IntegerInputSetFetch extends IntegerInputEvent {
  IntegerInputSetFetch({required this.fetch});

  final IntListFutureCallback fetch;
}

class IntegerInputSetFetchClear extends IntegerInputSetFetch {
  IntegerInputSetFetchClear({required super.fetch});
}
