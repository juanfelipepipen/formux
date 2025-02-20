import 'package:formux/widgets/container/formux_input_container.dart';
import 'package:pipen/extensions/context_extension.dart';
import 'package:formux/inputs/formux_string_input.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxInputText extends StatelessWidget {
  const FormuxInputText({super.key, this.value, required this.label, this.input});

  final FormuxInput? input;
  final String? value;
  final String label;

  @override
  Widget build(BuildContext context) => FormuxInputContainer(
        label: label,
        input: input ?? FormuxStringInput(),
        floatingLabelBehavior:
            value == null ? FloatingLabelBehavior.never : FloatingLabelBehavior.always,
        child: Text(
          value ?? label,
          style: value == null
              ? context.theme.inputDecorationTheme.hintStyle
              : context.theme.inputDecorationTheme.labelStyle,
        ),
      );
}
