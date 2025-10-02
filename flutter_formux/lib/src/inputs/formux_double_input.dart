import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:formux/formux.dart';

class FormuxDoubleInput extends FormuxDoubleType with FormuxTranslations {
  FormuxDoubleInput({super.required, super.value});

  FormuxDoubleInput.notRequired({double? value})
    : super(value: value ?? 0, required: false);

  double minValue = 0;

  @override
  void validator() {
    assertion(value == null, translations.required);
  }

  @override
  void clear() {
    value = 0;
    hideErrors();
  }
}
