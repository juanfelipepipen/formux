import 'package:pipen/formux/abstract/formux.dart';
import 'package:formux/abstract/formux_copy.dart';
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

    if (state case FormuxCopy<F> coppier) {
      emit(coppier.copy());
    } else {
      throw Exception("FormuxCopy is not defined in ${F.runtimeType}");
    }
  }
}
