import 'package:flutter_formux/flutter_formux.dart';
import 'package:flutter/material.dart';
import 'package:pipen/extensions.dart';
import 'package:formux/formux.dart';

class FormuxInputField extends StatelessWidget {
  const FormuxInputField({
    super.key,
    this.label,
    this.input,
    this.value,
    this.filled,
    this.enabled,
    this.fillColor,
    this.suffixIcon,
  }) : informative = false;

  const FormuxInputField.info({
    super.key,
    this.input,
    this.value,
    this.filled,
    this.enabled,
    this.fillColor,
    this.suffixIcon,
    required this.label,
  }) : informative = true;

  final bool? enabled, filled;
  final String? value, label;
  final FormuxInput? input;
  final Widget? suffixIcon;
  final bool informative;
  final Color? fillColor;

  String? get _value {
    if (informative) {
      return label;
    }
    return value;
  }

  FloatingLabelBehavior get _floatingLabelBehavior => value == null
      ? FloatingLabelBehavior.never
      : FloatingLabelBehavior.always;

  @override
  Widget build(BuildContext context) => FormuxInputContainer(
    label: label,
    filled: filled,
    enabled: enabled,
    fillColor: fillColor,
    suffixIcon: suffixIcon,
    input: input ?? FormuxStringInput(),
    floatingLabelBehavior: _floatingLabelBehavior,
    child: Text(
      _value ?? label ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: _value == null || enabled == false
          ? (input?.display == true
                ? context.theme.inputDecorationTheme.errorStyle
                : context.theme.inputDecorationTheme.labelStyle)
          : context.theme.inputDecorationTheme.hintStyle,
    ),
  );
}
