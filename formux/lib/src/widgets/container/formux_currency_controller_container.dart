import 'package:currency_textfield/currency_textfield.dart';
import 'package:formux/src/inputs/formux_double_input.dart';
import 'package:flutter/cupertino.dart';

class FormuxCurrencyControllerContainer extends StatefulWidget {
  const FormuxCurrencyControllerContainer({super.key, required this.input, required this.builder});

  final Widget Function(BuildContext, CurrencyTextFieldController) builder;
  final FormuxDoubleInput input;

  @override
  State<FormuxCurrencyControllerContainer> createState() => _FormuxCurrencyControllerContainerState();
}

class _FormuxCurrencyControllerContainerState extends State<FormuxCurrencyControllerContainer> {
  late CurrencyTextFieldController controller;

  @override
  void initState() {
    controller = textFieldController();
    compare();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FormuxCurrencyControllerContainer oldWidget) {
    compare();
    super.didUpdateWidget(oldWidget);
  }

  @protected
  CurrencyTextFieldController textFieldController([double value = 0]) {
    return CurrencyTextFieldController(
      currencySymbol: '',
      removeSymbol: true,
      decimalSymbol: '.',
      thousandSymbol: ',',
      initDoubleValue: value,
    );
  }

  /// Compare and update value
  void compare() {
    if (widget.input.value != controller.doubleValue) {
      setState(() => controller = textFieldController(widget.input.value ?? 0));
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, controller);
}
