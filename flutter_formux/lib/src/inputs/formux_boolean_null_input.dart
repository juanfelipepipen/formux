import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:formux/formux.dart';

class FormuxBooleanNullInput extends FormuxInput<bool?>
    with FormuxTranslations {
  FormuxBooleanNullInput({super.value});

  FormuxBooleanNullInput.notRequired({super.value}) : super(required: false);

  @override
  void validator() {
    assertion(value == null, translations.required);
  }

  @override
  void clear() {
    value = null;
    hideErrors();
  }
}
