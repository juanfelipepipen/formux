import 'package:flutter_formux/src/input_type/formux_valuable_type.dart';
import 'package:flutter_formux/src/mixin/translations_mixin.dart';

class FormuxValuableInput extends FormuxValuableType with FormuxTranslations {
  FormuxValuableInput({super.value, super.items, super.required, super.fetch});

  FormuxValuableInput.notRequired({super.value, super.items, super.fetch})
      : super(required: false);

  @override
  void clear() {
    value = null;
    hideErrors();
    clearItems();
  }

  @override
  void validator() {
    assertion(value == null, translations.required);
  }
}
