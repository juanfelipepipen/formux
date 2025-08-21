import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:formux/formux.dart';
import 'package:pipen/config/typedef.dart';

class FormuxStringValueInput extends FormuxInput<String?> with FormuxTranslations {
  FormuxStringValueInput({
    super.value,
    this.length,
    this.maxLength = 255,
    super.required,
    StringList? items,
  }) : items = items ?? [];

  factory FormuxStringValueInput.notRequired({String? value, int? length, StringList? items}) {
    return FormuxStringValueInput(required: false, value: value, length: length, items: items);
  }

  StringList items = [];
  final int maxLength;
  final int? length;

  @override
  void validator() {
    assertion(value == null, translations.required);
  }

  @override
  void clear({bool? required}) {
    value = '';
    this.required = required ?? this.required;
    hideErrors();
  }

  FormuxStringValueInput copyWith({String? value}) => FormuxStringValueInput(
    value: value,
    length: length,
    required: required,
    maxLength: maxLength,
  );
}
