import 'package:formux/src/formux.dart';

abstract class FormuxInputErrorCodes {
  /// ERROR_CODE, FormuxInput
  Map<String, FormuxInput> get codes;
}

class FormuxInputErrorCode {
  FormuxInputErrorCode({required this.code, required this.message});

  final String code, message;
}
