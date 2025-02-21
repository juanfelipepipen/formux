import 'package:formux/abstract/formux_copy.dart';
import 'package:formux/formux.dart';
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
}
