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
    this.border,
    this.filled,
    this.enabled,
    this.hintText,
    this.minLines,
    this.fillColor,
    this.controller,
    this.suffixIcon,
    this.onSubmitted,
    this.keyboardType,
    this.contentPadding,
    required this.input,
    required this.onChange,
    this.obscureText = false,
  });

  const FormuxTextField.obscureText({
    super.key,
    this.style,
    this.label,
    this.icon,
    this.border,
    this.filled,
    this.enabled,
    this.minLines,
    this.hintText,
    this.fillColor,
    this.controller,
    this.suffixIcon,
    this.onSubmitted,
    this.keyboardType,
    this.contentPadding,
    required this.input,
    required this.onChange,
  }) : obscureText = true;

  const FormuxTextField.textArea({
    super.key,
    this.style,
    this.label,
    this.icon,
    this.border,
    this.filled,
    this.enabled,
    this.hintText,
    this.fillColor,
    this.controller,
    this.suffixIcon,
    this.onSubmitted,
    this.minLines = 3,
    this.keyboardType,
    this.contentPadding,
    required this.input,
    required this.onChange,
    this.obscureText = false,
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

  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String) onChange;
  final VoidCallback? onSubmitted;
  final Widget? suffixIcon, icon;
  final bool? filled, enabled;
  final InputBorder? border;
  final FormuxInput input;
  final TextStyle? style;
  final String? hintText;
  final bool obscureText;
  final Color? fillColor;
  final int? minLines;
  final String? label;

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
            onFieldSubmitted: (_) {
              onSubmitted?.call();
            },
            decoration: InputDecoration(
              icon: icon,
              border: border,
              filled: filled,
              labelText: label,
              hintStyle: style,
              labelStyle: style,
              hintText: hintText,
              fillColor: fillColor,
              errorText: errorText,
              enabledBorder: border,
              suffixIcon: suffixIcon,
              contentPadding: contentPadding,
              focusColor: context.themeColors.primary,
              errorStyle: TextStyle(color: context.themeColors.error),
              floatingLabelStyle: style?.copyWith(color: context.themeColors.primary),
            ),
          ),
    ),
  );
}
