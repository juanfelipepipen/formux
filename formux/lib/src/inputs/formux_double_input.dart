import 'package:formux/src/input_type/formux_double_type.dart';
import 'package:formux/src/mixin/translations_mixin.dart';

class FormuxDoubleInput extends FormuxDoubleType with Translations {
  FormuxDoubleInput({super.required, super.value});

  FormuxDoubleInput.notRequired({double? value}) : super(value: value ?? 0, required: false);

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
