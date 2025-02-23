import 'package:formux/widgets/container/formux_input_container.dart';
import 'package:pipen/extensions/context_extension.dart';
import 'package:formux/inputs/formux_string_input.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxInputField extends StatelessWidget {
  const FormuxInputField({
    super.key,
    this.input,
    this.value,
    this.enabled,
    this.suffixIcon,
    required this.label,
  }) : informative = false;

  const FormuxInputField.info({
    super.key,
    this.input,
    this.value,
    this.suffixIcon,
    this.enabled,
    required this.label,
  }) : informative = true;

  final FormuxInput? input;
  final Widget? suffixIcon;
  final bool informative;
  final bool? enabled;
  final String? value;
  final String label;

  String? get _value {
    if (informative) {
      return label;
    }
    return value;
  }

  FloatingLabelBehavior get _floatingLabelBehavior =>
      value == null ? FloatingLabelBehavior.never : FloatingLabelBehavior.always;

  @override
  Widget build(BuildContext context) => FormuxInputContainer(
    label: label,
    enabled: enabled,
    suffixIcon: suffixIcon,
    input: input ?? FormuxStringInput(),
    floatingLabelBehavior: _floatingLabelBehavior,
    child: Text(
      _value ?? label,
      style:
          _value == null || enabled == false
              ? context.theme.inputDecorationTheme.hintStyle
              : context.textTheme.bodyLarge,
    ),
  );
}
