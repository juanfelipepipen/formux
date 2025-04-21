import 'package:formux/src/abstract/formux_input_ids.dart';
import 'package:formux/src/models/input_error.dart';
import 'package:formux/src/formux.dart';

class InputErrorsException implements Exception {
  InputErrorsException({required this.errors});

  List<InputError> errors;

  /// Add error to form
  void form(FormuxInputIds form) {
    for (String field in form.ids.keys) {
      int index = errors.indexWhere((element) => element.field == field);
      if (index > -1) {
        String error = errors[index].errors.first;
        form.ids[field]?.addError(error);
        errors.removeAt(index);
      }
    }
  }

  /// Error on input
  void input(FormuxInput input, String key) {
    int index = errors.indexWhere((element) => element.field == key);
    if (index > -1) {
      String error = errors[index].errors.first;
      input.addError(error);
      errors.removeAt(index);
    }
  }
}
