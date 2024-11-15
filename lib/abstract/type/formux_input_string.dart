import 'package:formux/abstract/formux_input.dart';

abstract class FormuxInputString extends FormuxInput<String> {
  FormuxInputString({super.value = '', super.required});

  String? get valueOrNull => value.isEmpty ? null : value;

  /// Update value from dynamic
  void update(dynamic value) {
    value == null ? this.value = '' : this.value = value.toString();
  }

  @override
  void clear() => value = '';
}
