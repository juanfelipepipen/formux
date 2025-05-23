import 'package:flutter/cupertino.dart';

abstract class FormuxErrorCodesManager {
  /// Errors codes translations
  Map<String, String> Function(BuildContext) get errors;

  /// On unknown error code
  Function(BuildContext context, String errorCode) get onUnknownCode;
}
