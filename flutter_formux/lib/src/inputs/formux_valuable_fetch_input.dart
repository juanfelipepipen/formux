import 'package:flutter_formux/src/input_type/formux_valuable_type.dart';
import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:pipen/valuable.dart';
import 'package:formux/formux.dart';

typedef ValuableInputEvent = DropdownInputEvent<Valuable>;
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
    if (event case DropdownSetValue<Valuable> event) {
      value = event.value;
    }

    if (event case DropdownSetItems<Valuable> event) {
      items = event.items;
    }

    if (event case DropdownSetFetch<Valuable> event) {
      fetch = event.fetch;
      items = [];
      hideErrors();
    }

    if (event case DropdownSetFetchClear<Valuable> event) {
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
