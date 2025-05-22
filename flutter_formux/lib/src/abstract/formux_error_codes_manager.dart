import 'package:flutter/cupertino.dart';

class FormuxErrorCodesManager {
  /// Errors codes translations
  static Map<String, String> Function(BuildContext)? errors;

  /// On unknown error code
  static Function(BuildContext context, String errorCode)? onUnknownCode;
}
