import 'package:formux/src/input_type/formux_valuable_type.dart';
import 'package:formux/src/mixin/translations_mixin.dart';

class FormuxValuableInput extends FormuxValuableType with Translations {
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
