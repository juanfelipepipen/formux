import 'package:formux/formux.dart';
import 'package:formux/mixin/translations_mixin.dart';

class FormuxBooleanNullInput extends FormuxInput<bool?> with Translations {
  FormuxBooleanNullInput({bool? value}) : super(value: value ?? false);

  FormuxBooleanNullInput.notRequired() : super(value: false, required: false);

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
