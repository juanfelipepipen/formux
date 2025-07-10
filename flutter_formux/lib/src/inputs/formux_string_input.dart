import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:formux/formux.dart';

class FormuxStringInput extends FormuxStringType with FormuxTranslations {
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
