import 'package:flutter_formux/src/widgets/container/formux_input_container.dart';
import 'package:flutter_formux/src/inputs/formux_string_input.dart';
import 'package:flutter/material.dart';
import 'package:pipen/extensions.dart';
import 'package:formux/formux.dart';

class FormuxInputField extends StatelessWidget {
  const FormuxInputField({
    super.key,
    this.label,
    this.input,
    this.value,
    this.enabled,
    this.suffixIcon,
  }) : informative = false;

  const FormuxInputField.info({
    super.key,
    this.input,
    this.value,
    this.suffixIcon,
    this.enabled,
    required this.label,
  }) : informative = true;

  final String? value, label;
  final FormuxInput? input;
  final Widget? suffixIcon;
  final bool informative;
  final bool? enabled;

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
      _value ?? label ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style:
          _value == null || enabled == false
              ? (input?.display == true
                  ? context.theme.inputDecorationTheme.errorStyle
                  : context.theme.inputDecorationTheme.labelStyle)
              : context.theme.inputDecorationTheme.hintStyle,
    ),
  );
}
