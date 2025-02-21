import 'package:formux/abstract/cubit_formux_input_error.dart';
import 'package:formux/exceptions/input_errors_exception.dart';
import 'package:pipen_bloc/models/exception_strategy.dart';
import 'package:flutter/widgets.dart';

class FormuxInputErrorsStrategy extends ExceptionStrategy {
  @override
  bool callable(instance, exception) {
    return instance is CubitFormuxInputError && exception is InputErrorsException;
  }

  @override
  void handle(BuildContext context, instance, exception) {
    exception = exception as InputErrorsException;
    instance = instance as CubitFormuxInputError;
    instance.cubitForm.inputErrors(exception);
  }
}
