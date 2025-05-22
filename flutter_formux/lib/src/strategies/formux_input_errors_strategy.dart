import 'package:flutter_formux/flutter_formux.dart';
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

    Map<String, String> codes = FormuxErrorCodesManager.errors?.call(context) ?? {};
    onUnknownCode() => FormuxErrorCodesManager.onUnknownCode?.call(context, exception.errorCode);

    if (codes[exception.errorCode] case String message) {
      List<FormuxInputErrorCode> errorCodes = [
        FormuxInputErrorCode(code: exception.errorCode, message: message),
      ];
      listener.cubitForm.errorCodes(errorCodes);

      if (errorCodes.isNotEmpty) {
        onUnknownCode();
      }
    }

    onUnknownCode();
  }
}
