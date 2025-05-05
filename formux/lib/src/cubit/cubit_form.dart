import 'package:formux/src/exceptions/input_errors_exception.dart';
import 'package:formux/src/abstract/formux_input_ids.dart';
import 'package:formux/src/abstract/formux_copy.dart';
import 'package:formux/src/formux.dart';
import 'package:bloc/bloc.dart';

abstract class CubitForm<F extends Formux> extends Cubit<F> {
  CubitForm(super.initialState);

  /// Validate form and if is valid, call method and
  /// emit new state from parent
  void validate(Function(F form) onValid) {
    F form = state;
    bool valid = form.valid();

    if (valid) {
      onValid.call(form);
    }

    emit(_copyForm());
  }

  /// Get copy at current form
  F _copyForm() {
    if (state case FormuxCopy<F> coppier) {
      return coppier.copy();
    } else {
      throw Exception("FormuxCopy is not defined in ${F.runtimeType}");
    }
  }

  /// Add error to form with id
  void inputErrors(InputErrorsException inputErrors) {
    final form = _copyForm();

    if (form case FormuxInputIds inputIds) {
      inputErrors.form(inputIds);
    }
    emit(form);
  }
}
