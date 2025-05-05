import 'package:flutter/foundation.dart';
import 'package:formux/src/formux.dart';

mixin FormuxValidEvent<F extends Formux> {
  /// Emitter for a new state from parent
  VoidCallback get updater;

  /// From
  F get form;

  /// Validate form and if is valid, call method and
  /// emit new state from parent
  void onValidation(Function(F form) onValid) {
    if (this case FormuxValidEvent event) {
      bool valid = form.valid();

      if (valid) {
        onValid.call(form);
      }

      event.updater();
    }
  }
}
