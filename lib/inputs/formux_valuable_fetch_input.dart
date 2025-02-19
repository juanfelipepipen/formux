import 'package:formux/input_type/formux_valuable_type.dart';
import 'package:formux/mixin/translations_mixin.dart';
import 'package:pipen/valuable/valuable.dart';

typedef OnValuableEventChange = Function(ValuableInputEvent);

class FormuxValuableFetchInput extends FormuxValuableType with Translations {
  FormuxValuableFetchInput({super.value, super.items, super.fetch, super.required});

  @override
  void clear() {
    value = null;
    hideErrors();
  }

  @override
  void validator() {
    assertion(value == null, translations.required);
  }

  /// Set input event
  void event(ValuableInputEvent event) {
    if (event case ValuableSetValue event) {
      value = event.value;
    }

    if (event case ValuableSetItems event) {
      items = event.items;
    }

    if (event case ValuableSetFetch event) {
      fetch = event.fetch;
      items = [];
    }

    if (event case ValuableSetFetchClear event) {
      value = null;
      fetch = event.fetch;
      hideErrors();
    }
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

sealed class ValuableInputEvent {}

class ValuableSetValue extends ValuableInputEvent {
  ValuableSetValue({required this.value});

  Valuable value;
}

class ValuableSetItems extends ValuableInputEvent {
  ValuableSetItems({required this.items});

  ValuableList items;
}

class ValuableSetFetch extends ValuableInputEvent {
  ValuableSetFetch({required this.fetch});

  ValuableListFetchCallback fetch;
}

class ValuableSetFetchClear extends ValuableInputEvent {
  ValuableSetFetchClear({required this.fetch});

  ValuableListFetchCallback fetch;
}
