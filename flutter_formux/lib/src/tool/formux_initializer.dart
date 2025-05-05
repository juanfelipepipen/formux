import 'package:flutter_formux/src/strategies/formux_input_errors_strategy.dart';
import 'package:pipen_bloc/listen/bloc_listen.dart';

class FormuxInitializer {
  /// Initialize formux tools
  static void binding() {
    BlocListen.strategies.add(FormuxInputErrorsStrategy());
  }
}
