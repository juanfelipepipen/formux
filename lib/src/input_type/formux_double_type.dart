import 'package:formux/src/formux.dart';

abstract class FormuxDoubleType extends FormuxInput<double?> {
  FormuxDoubleType({super.value, super.required});

  @override
  String valueToString() {
    return value != null ? value.toString() : '';
  }
}
