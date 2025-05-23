import 'package:formux/formux.dart';
import 'package:pipen_bloc/models/exception_strategy.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:pipen/graphql.dart';

class FormuxInputValidationsStrategy extends ListenException {
  @override
  bool callable(listener, exception) {
    return listener is CubitFormuxInputError && exception is GraphqlValidationErrors;
  }

  @override
  void handle(context, listener, exception) {
    exception = exception as GraphqlValidationErrors;
    listener as CubitFormuxInputError;
    final errors =
        exception.errors.map((e) => InputError(field: e.field, errors: e.errors)).toList();
    listener.cubitForm.inputErrors(errors);

    if (errors.isNotEmpty) {
      FlutterFormux.errorsManager?.onUnknownCode.call(context, 'Validation errors');
    }
  }
}
