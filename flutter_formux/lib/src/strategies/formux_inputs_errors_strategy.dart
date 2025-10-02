import 'package:flutter_formux/flutter_formux.dart';
import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:formux/formux.dart';
import 'package:pipen/graphql.dart';

class FormuxInputsErrorsStrategy extends ListenException {
  @override
  bool callable(listener, exception) {
    return exception is GraphqlValidationErrors;
  }

  @override
  void handle(context, listener, exception) {
    exception = exception as GraphqlValidationErrors;
    final errors = exception.errors
        .map<InputError>((e) => InputError(field: e.field, errors: e.errors))
        .toList();

    onInputErrors() {
      FlutterFormux.errorsManager?.onInputErrors.call(context, errors);
    }

    // Listener don't support formux error
    if (listener is! ListenFormuxError) {
      return onInputErrors();
    }

    listener.cubitForm.inputErrors(errors);
    if (errors.isNotEmpty) {
      onInputErrors();
    }
  }
}
