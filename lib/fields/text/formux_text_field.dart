import 'package:formux/widgets/container/formux_controller_container.dart';
import 'package:formux/fields/text/formux_password_field.dart';
import 'package:formux/input_type/formux_string_type.dart';
import 'package:pipen/extensions/context_extension.dart';
import 'package:pipen/components/gap/pipen_gap.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxTextField extends StatelessWidget {
  const FormuxTextField({
    super.key,
    this.style,
    this.label,
    this.icon,
    this.prefix,
    this.suffix,
    this.border,
    this.filled,
    this.enabled,
    this.hintText,
    this.hintStyle,
    this.minLines,
    this.fillColor,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.helperText,
    this.controller,
    this.suffixIcon,
    this.onSubmitted,
    this.keyboardType,
    this.contentPadding,
    required this.input,
    required this.onChange,
    this.obscureText = false,
    this.floatingLabelBehavior,
  });

  const FormuxTextField.obscureText({
    super.key,
    this.style,
    this.label,
    this.icon,
    this.prefix,
    this.suffix,
    this.border,
    this.filled,
    this.enabled,
    this.minLines,
    this.hintText,
    this.hintStyle,
    this.fillColor,
    this.prefixIcon,
    this.prefixText,
    this.suffixText,
    this.controller,
    this.helperText,
    this.suffixIcon,
    this.onSubmitted,
    this.keyboardType,
    this.contentPadding,
    required this.input,
    required this.onChange,
    this.floatingLabelBehavior,
  }) : obscureText = true;

  const FormuxTextField.textArea({
    super.key,
    this.style,
    this.label,
    this.icon,
    this.border,
    this.prefix,
    this.suffix,
    this.filled,
    this.enabled,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.fillColor,
    this.prefixText,
    this.suffixText,
    this.helperText,
    this.controller,
    this.suffixIcon,
    this.onSubmitted,
    this.minLines = 3,
    this.keyboardType,
    this.contentPadding,
    required this.input,
    required this.onChange,
    this.obscureText = false,
    this.floatingLabelBehavior,
  });

  static FormuxPasswordField password({
    EdgeInsetsGeometry? contentPadding,
    required Function(String) onChange,
    required FormuxStringType input,
    VoidCallback? onSubmitted,
    InputBorder? border,
    TextStyle? style,
    Color? fillColor,
    String? label,
    bool? filled,
    enabled,
  }) => FormuxPasswordField(
    label: label,
    input: input,
    style: style,
    filled: filled,
    border: border,
    enabled: enabled,
    onChange: onChange,
    fillColor: fillColor,
    onSubmitted: onSubmitted,
    contentPadding: contentPadding,
  );

  final Widget? suffixIcon, icon, prefixIcon, prefix, suffix;
  final String? label, prefixText, suffixText, helperText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? style, hintStyle;
  final Function(String) onChange;
  final VoidCallback? onSubmitted;
  final bool? filled, enabled;
  final InputBorder? border;
  final FormuxInput input;
  final String? hintText;
  final bool obscureText;
  final Color? fillColor;
  final int? minLines;

  @override
  Widget build(BuildContext context) => PipenGap.small(
    child: FormuxControllerContainer(
      input: input,
      builder:
          (context, formuxController, errorText) => TextFormField(
            enabled: enabled,
            minLines: minLines,
            onChanged: onChange,
            maxLines: minLines ?? 1,
            obscureText: obscureText,
            keyboardType: keyboardType,
            controller: controller ?? formuxController,
            onFieldSubmitted: (_) => onSubmitted?.call(),
            decoration: InputDecoration(
              icon: icon,
              border: border,
              filled: filled,
              prefix: prefix,
              suffix: suffix,
              labelText: label,
              labelStyle: style,
              hintText: hintText,
              fillColor: fillColor,
              errorText: errorText,
              enabledBorder: border,
              prefixText: prefixText,
              prefixIcon: prefixIcon,
              suffixText: suffixText,
              helperText: helperText,
              suffixIcon: suffixIcon,
              hintStyle: hintStyle ?? style,
              contentPadding: contentPadding,
              focusColor: context.themeColors.primary,
              floatingLabelBehavior: floatingLabelBehavior,
              errorStyle: TextStyle(color: context.themeColors.error),
              floatingLabelStyle: style?.copyWith(color: context.themeColors.primary),
            ),
          ),
    ),
  );
}
