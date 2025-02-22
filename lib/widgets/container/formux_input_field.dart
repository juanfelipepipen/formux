import 'package:flutter/material.dart';
import 'package:formux/formux.dart';
import 'package:formux/inputs/formux_string_input.dart';
import 'package:formux/widgets/container/formux_input_container.dart';
import 'package:pipen/extensions/context_extension.dart';

class FormuxInputField extends StatelessWidget {
  const FormuxInputField({super.key, this.input, required this.label, this.value, this.suffixIcon})
    : informative = false;

  const FormuxInputField.info({
    super.key,
    this.input,
    required this.label,
    this.value,
    this.suffixIcon,
  }) : informative = true;

  final FormuxInput? input;
  final Widget? suffixIcon;
  final bool informative;
  final String? value;
  final String label;

  String? get _value {
    if (informative) {
      return label;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) => FormuxInputContainer(
    label: label,
    input: input ?? FormuxStringInput(),
    suffixIcon: suffixIcon,
    floatingLabelBehavior:
        value == null ? FloatingLabelBehavior.never : FloatingLabelBehavior.always,
    child: Text(
      _value ?? label,
      style:
          _value == null
              ? context.theme.inputDecorationTheme.hintStyle
              : context.textTheme.bodyLarge,
    ),
  );
}
