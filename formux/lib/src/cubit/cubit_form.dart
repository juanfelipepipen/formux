import 'package:formux/formux.dart';
import 'package:bloc/bloc.dart';

abstract class CubitForm<F extends Formux> extends Cubit<F> {
  CubitForm(super.initialState) {
    assert(state is FormuxCopy<F>);
  }

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

  /// Add errors from error codes list
  void errorCodes(List<FormuxInputErrorCode> codes) {
    final form = _copyForm();
    final codesFind = [];

    if (form case FormuxInputErrorCodes formCodes) {
      for (final error in codes) {
        if (formCodes.codes.keys.contains(error.code)) {
          formCodes.codes[error.code]!.addError(error.message);
          codesFind.add(error);
        }
      }
    }

    // Remove errors codes find
    for (final errorCode in codesFind) {
      codes.remove(errorCode);
    }

    emit(form);
  }
}
