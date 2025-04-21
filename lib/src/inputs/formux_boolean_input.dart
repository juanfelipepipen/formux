import 'package:formux/src/formux.dart';
import 'package:formux/src/mixin/translations_mixin.dart';

class FormuxBooleanInput extends FormuxInput<bool> with Translations {
  FormuxBooleanInput({bool? value}) : super(value: value ?? false);

  FormuxBooleanInput.notRequired() : super(value: false, required: false);

  @override
  void validator() {
    assertion(!value, translations.required);
  }

  @override
  void clear() => value = false;
}
