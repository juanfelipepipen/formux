import 'package:pipen/valuable/valuable.dart';
import 'package:formux/formux.dart';

abstract class FormuxValuableType extends FormuxInput<Valuable?> {
  FormuxValuableType({required super.value, List<Valuable>? items, super.required, this.fetch}) {
    if (items != null) {
      items = items;
    }
  }

  ValuableListFetchCallback? fetch;
  List<Valuable> items = [];

  /// Get the current value index from items list
  int? getValueIndexList() {
    if (value != null && items.isNotEmpty) {
      int index = items.indexWhere((element) => element.value == value!.value);
      return index > -1 ? index : null;
    }
    return null;
  }

  /// Add items to items list from valuable values
  void addItemValues({required String title, required String value}) {
    items.add(Valuable(title: title, value: value));
  }

  /// Clear items list
  void clearItems() {
    items = [];
  }

  /// Get item from index
  Valuable? getItem(int index) {
    return items.length >= index ? items[index] : null;
  }

  /// Update from id
  void update(String id) {
    bool contains = items.indexWhere((element) => element.value == id) != -1;
    if (contains) {
      value = items.firstWhere((element) => element.value == id);
    }
  }

  /// Update from id
  void valueWithoutError(Valuable? value) {
    if (value == null) {
      hideErrors();
    } else {
      this.value = value;
    }
  }
}
