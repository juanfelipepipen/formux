import 'package:flutter_formux/src/mixin/translations_mixin.dart';
import 'package:formux/formux.dart';

class FormuxBooleanInput extends FormuxInput<bool> with Translations {
  FormuxBooleanInput({bool? value}) : super(value: value ?? false);

  FormuxBooleanInput.notRequired() : super(value: false, required: false);

  @override
  void validator() {
    assertion(!value, translations.required);
  }

  @override
  void clear() => value = false;

  /// Set false if value is null
  void setFromNullable(bool? value) => this.value = value ?? false;
}
