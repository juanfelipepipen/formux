import 'package:flutter/cupertino.dart';
import 'package:formux/formux.dart';

abstract class FormuxErrorCodesManager {
  /// Errors codes translations
  Map<String, String> Function(BuildContext) get errorsTranslations;

  /// On unknown error code
  Function(BuildContext context, String errorCode) get onErrorCode;

  /// On validation input errors
  Function(BuildContext context, List<InputError> errors) get onInputErrors;
}
