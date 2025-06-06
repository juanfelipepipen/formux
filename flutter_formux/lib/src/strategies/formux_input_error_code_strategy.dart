import 'package:flutter/material.dart';
import 'package:pipen_bloc/models/exception_strategy.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:formux/formux.dart';
import 'package:pipen/graphql.dart';

class FormuxInputErrorCodeStrategy extends ListenException {
  @override
  bool callable(listener, exception) {
    return listener is ListenFormuxError && exception is GraphqlErrorCode;
  }

  @override
  void handle(context, listener, originalException) {
    final exception = originalException as GraphqlErrorCode;
    listener = listener as ListenFormuxError;

    // List of error codes with her translation
    Map<String, String> codes = FlutterFormux.errorsManager?.errorsTranslations.call(context) ?? {};

    // Handle if error code is not for a input on form
    onUnknownCode() {
      final onErrorCode = FlutterFormux.errorsManager?.onErrorCode;

      if (onErrorCode == null) {
        final snackBar = SnackBar(content: Text(exception.errorCode));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      onErrorCode.call(context, exception.errorCode);
    }

    if (codes[exception.errorCode] case String message) {
      final errorCodes = <FormuxInputErrorCode>[
        FormuxInputErrorCode(code: exception.errorCode, message: message),
      ];
      listener.cubitForm.errorCodes(errorCodes);
      if (errorCodes.isNotEmpty) onUnknownCode();
      return;
    }

    onUnknownCode();
  }
}
