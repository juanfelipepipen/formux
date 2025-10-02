import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:formux/formux.dart';

enum FormuxStringInputValidations { onlyAlphanumeric }

class FormuxStringInput extends FormuxStringType with FormuxTranslations {
  FormuxStringInput({
    String? value,
    super.required,
    this.length,
    this.maxLength = 255,
    List<FormuxStringInputValidations>? validations,
  }) : validations = validations ?? [],
       super(value: value ?? '');

  factory FormuxStringInput.notRequired({String? value, int? length}) =>
      FormuxStringInput(required: false, value: value, length: length);

  final List<FormuxStringInputValidations> validations;
  final int maxLength;
  final int? length;

  @override
  void validator() {
    assertion(value.isEmpty, translations.required);
    assertion(value.length > maxLength, translations.fixedLength(maxLength));

    if (validations.contains(FormuxStringInputValidations.onlyAlphanumeric)) {
      RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
      assertion(!regex.hasMatch(value), translations.onlyAlphanumeric);
    }
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

  FormuxStringInput copyWith({
    int? length,
    String? value,
    bool? required,
    int? maxLength,
    List<FormuxStringInputValidations>? validations,
  }) => FormuxStringInput(
    value: value ?? this.value,
    length: length ?? this.length,
    required: required ?? this.required,
    maxLength: maxLength ?? this.maxLength,
    validations: validations ?? this.validations,
  );
}
