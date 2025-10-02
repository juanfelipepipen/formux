import 'package:flutter_formux/flutter_formux.dart';
import 'package:pipen/extensions.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxInputText extends StatelessWidget {
  const FormuxInputText({
    super.key,
    this.value,
    this.enabled,
    this.input,
    required this.label,
  });

  final FormuxInput? input;
  final bool? enabled;
  final String? value;
  final String label;

  @override
  Widget build(BuildContext context) => FormuxInputContainer(
    label: label,
    enabled: enabled,
    input: input ?? FormuxStringInput(),
    floatingLabelBehavior: value == null
        ? FloatingLabelBehavior.never
        : FloatingLabelBehavior.always,
    child: Text(
      value ?? label,
      style: value == null
          ? context.theme.inputDecorationTheme.hintStyle
          : context.theme.inputDecorationTheme.labelStyle,
    ),
  );
}
