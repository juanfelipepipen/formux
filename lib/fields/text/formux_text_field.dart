import 'package:formux/fields/text/formux_password_field.dart';
import 'package:formux/input_type/formux_string_type.dart';
import 'package:pipen/extensions/context_extension.dart';
import 'package:pipen/components/gap/pipen_gap.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxTextField extends StatefulWidget {
  const FormuxTextField({
    super.key,
    this.style,
    this.label,
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
  final bool? filled, enabled;
  final InputBorder? border;
  final Widget? suffixIcon;
  final FormuxInput input;
  final TextStyle? style;
  final String? hintText;
  final bool obscureText;
  final Color? fillColor;
  final int? minLines;
  final String? label;

  @override
  State<FormuxTextField> createState() => _FormuxTextFieldState();
}

class _FormuxTextFieldState extends State<FormuxTextField> {
  late TextEditingController controller;

  String? get errorText => widget.input.display ? widget.input.error : null;

  @override
  void initState() {
    controller = TextEditingController();
    updateText();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormuxTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateText();
  }

  /// Compare and update text in text controller
  void updateText() {
    if (widget.input.valueToString() != controller.text) {
      setState(() => controller.text = widget.input.valueToString());
    }
  }

  @override
  Widget build(BuildContext context) => PipenGap.small(
    child: TextFormField(
      enabled: widget.enabled,
      minLines: widget.minLines,
      onChanged: widget.onChange,
      maxLines: widget.minLines ?? 1,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller ?? controller,
      onFieldSubmitted: (_) {
        widget.onSubmitted?.call();
      },
      decoration: InputDecoration(
        errorText: errorText,
        border: widget.border,
        filled: widget.filled,
        labelText: widget.label,
        hintStyle: widget.style,
        labelStyle: widget.style,
        hintText: widget.hintText,
        fillColor: widget.fillColor,
        enabledBorder: widget.border,
        suffixIcon: widget.suffixIcon,
        contentPadding: widget.contentPadding,
        focusColor: context.themeColors.primary,
        errorStyle: TextStyle(color: context.themeColors.error),
        floatingLabelStyle: widget.style?.copyWith(color: context.themeColors.primary),
      ),
    ),
  );
}
