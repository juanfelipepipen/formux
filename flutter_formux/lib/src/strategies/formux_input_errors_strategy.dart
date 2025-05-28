import 'package:pipen_bloc/models/exception_strategy.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:formux/formux.dart';
import 'package:pipen/graphql.dart';

class FormuxInputErrorsStrategy extends ListenException {
  @override
  bool callable(listener, exception) {
    return listener is ListenFormuxError && exception is GraphqlErrorCode;
  }

  @override
  void handle(context, listener, exception) {
    exception = exception as GraphqlErrorCode;
    listener = listener as ListenFormuxError;

    Map<String, String> codes = FlutterFormux.errorsManager?.errorsTranslations.call(context) ?? {};
    onUnknownCode() => FlutterFormux.errorsManager?.onErrorCode.call(context, exception.errorCode);

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
