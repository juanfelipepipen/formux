import 'package:flutter_formux/src/strategies/formux_input_error_code_strategy.dart';
import 'package:flutter_formux/src/strategies/formux_inputs_errors_strategy.dart';
import 'package:pipen_bloc/pipen_bloc.dart';

class FormuxInitializer {
  /// Initialize formux tools
  static void binding() {
    BlocListen.strategies.addAll([FormuxInputErrorCodeStrategy(), FormuxInputsErrorsStrategy()]);
  }
}
