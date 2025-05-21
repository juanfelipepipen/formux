import 'package:flutter_formux/src/abstract/cubit_formux_input_error.dart';
import 'package:formux/formux.dart';
import 'package:pipen/graphql.dart';
import 'package:pipen_bloc/models/exception_strategy.dart';

class FormuxInputErrorsStrategy extends ListenException {
  @override
  bool callable(listener, exception) {
    return listener is CubitFormuxInputError && exception is GraphqlErrorCode;
  }

  @override
  void handle(context, listener, exception) {
    exception = exception as GraphqlErrorCode;
    listener = listener as CubitFormuxInputError;
    List<FormuxInputErrorCode> errorCodes = [
      FormuxInputErrorCode(code: exception.errorCode, message: 'Esto es un mensaje de error'),
    ];
    listener.cubitForm.errorCodes(errorCodes);
    if (errorCodes.isEmpty) {
      print("ERRORES MAPEADOS");
    }
  }
}
