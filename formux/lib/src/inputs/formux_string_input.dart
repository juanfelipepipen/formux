import 'package:formux/src/input_type/formux_string_type.dart';
import 'package:formux/src/mixin/translations_mixin.dart';

class FormuxStringInput extends FormuxStringType with Translations {
  FormuxStringInput({
    String? value,
    this.length,
    this.maxLength = 255,
    super.required,
  }) : super(value: value ?? '');

  factory FormuxStringInput.notRequired({String? value, int? length}) =>
      FormuxStringInput(required: false, value: value, length: length);

  int maxLength;
  int? length;

  @override
  void validator() {
    assertion(value.isEmpty, translations.required);
    assertion(value.length > maxLength, translations.fixedLength(maxLength));
  }

  @override
  void clear({bool? required}) {
    value = '';
    this.required = required ?? this.required;
    hideErrors();
  }

  /// Set value from string nullable
  void setFromNullable(String? value) {
    this.value = value ?? '';
  }

  FormuxStringInput copyWith({String? value}) => FormuxStringInput(
        value: value,
        length: length,
        required: required,
        maxLength: maxLength,
      );
}
