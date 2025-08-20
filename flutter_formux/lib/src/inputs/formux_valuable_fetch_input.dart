import 'package:flutter_formux/src/input_type/formux_valuable_type.dart';
import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:pipen/valuable.dart';

typedef OnValuableEventChange = Function(ValuableInputEvent);

class FormuxValuableFetchInput extends FormuxValuableType with FormuxTranslations {
  FormuxValuableFetchInput({super.value, super.items, super.fetch, super.required});

  @override
  void clear() {
    value = null;
    fetch = null;
    items = [];
    hideErrors();
  }

  @override
  void validator() {
    assertion(value == null, translations.required);
  }

  /// Set input event
  void event(ValuableInputEvent event) {
    final callback = switch (event) {
      ValuableInputSetValue() => () {
        value = event.value;
      },
      ValuableInputSetItems() => () {
        fetch = null;
        items = event.items;
      },
      ValuableInputSetFetchClear() => () {
        fetch = event.fetch;
        value = null;
        hideErrors();
      },
      ValuableInputSetFetch() => () {
        fetch = event.fetch;
        items = [];
        hideErrors();
      },
    };
    callback();
  }

  Valuable? get valueFromItems {
    if (value == null || items.isEmpty) {
      return null;
    }

    final index = items.indexWhere((e) => e.value == value?.value);

    if (index == -1) {
      return null;
    }

    return items[index];
  }

  /// Update from id
  void valueFromId(dynamic id) {
    if (id case String id) {
      bool contains = items.indexWhere((element) => element.value == id) != -1;
      if (contains) {
        value = items.firstWhere((element) => element.value == id);
      }
    }
  }
}

sealed class ValuableInputEvent {
  static ValuableInputSetValue setValue(Valuable value) => ValuableInputSetValue(value: value);
  static ValuableInputSetItems setItems(ValuableList items) => ValuableInputSetItems(items: items);
  static ValuableInputSetFetch setFetch(ValuableListFetchCallback fetch) =>
      ValuableInputSetFetch(fetch: fetch);
  static ValuableInputSetFetchClear setFetchClear(ValuableListFetchCallback fetch) =>
      ValuableInputSetFetchClear(fetch: fetch);
}

class ValuableInputSetValue extends ValuableInputEvent {
  ValuableInputSetValue({required this.value});

  final Valuable value;
}

class ValuableInputSetItems extends ValuableInputEvent {
  ValuableInputSetItems({required this.items});

  final ValuableList items;
}

class ValuableInputSetFetch extends ValuableInputEvent {
  ValuableInputSetFetch({required this.fetch});

  final ValuableListFetchCallback fetch;
}

class ValuableInputSetFetchClear extends ValuableInputSetFetch {
  ValuableInputSetFetchClear({required super.fetch});
}
