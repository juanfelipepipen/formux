import 'package:pipen/extensions/context_extension.dart';
import 'package:formux/inputs/formux_input_string.dart';
import 'package:pipen/components/gap/pipen_gap.dart';
import 'package:flutter/material.dart';

class FormuxTextField extends StatefulWidget {
  const FormuxTextField({
    super.key,
    this.style,
    this.border,
    this.minLines,
    this.suffixIcon,
    this.obscureText = false,
    this.contentPadding,
    required this.label,
    required this.input,
    required this.onChange,
  });

  const FormuxTextField.obscureText({
    super.key,
    this.style,
    this.border,
    this.minLines,
    this.suffixIcon,
    this.contentPadding,
    required this.label,
    required this.input,
    required this.onChange,
  }) : obscureText = true;

  const FormuxTextField.textArea({
    super.key,
    this.style,
    this.border,
    this.suffixIcon,
    this.minLines = 3,
    this.obscureText = false,
    this.contentPadding,
    required this.label,
    required this.input,
    required this.onChange,
  });

  final EdgeInsetsGeometry? contentPadding;
  final Function(String) onChange;
  final FormuxInputString input;
  final InputBorder? border;
  final Widget? suffixIcon;
  final TextStyle? style;
  final bool obscureText;
  final int? minLines;
  final String label;

  @override
  State<FormuxTextField> createState() => _FormuxTextFieldState();
}

class _FormuxTextFieldState extends State<FormuxTextField> {
  late TextEditingController controller;
  InputBorder? errorBorder;

  String? get errorText => widget.input.display ? widget.input.error : null;

  @override
  void initState() {
    controller = TextEditingController();
    updateText();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    initInputBorder();
    super.didChangeDependencies();
  }

  /// Set the default border
  void initInputBorder() {
    final defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: context.themeColors.error, width: 2.0),
    );

    final widgetBorder = widget.border?.copyWith(
      borderSide: BorderSide(color: context.themeColors.error, width: 2.0),
    );

    setState(() => errorBorder = widgetBorder ?? defaultBorder);
  }

  @override
  void didUpdateWidget(covariant FormuxTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateText();
  }

  /// Compare and update text in text controller
  void updateText() {
    if (widget.input.value != controller.text) {
      setState(() => controller.text = widget.input.value);
    }
  }

  @override
  Widget build(BuildContext context) => PipenGap.small(
        child: TextField(
          controller: controller,
          minLines: widget.minLines,
          onChanged: widget.onChange,
          maxLines: widget.minLines ?? 1,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            contentPadding: widget.contentPadding,
            errorText: errorText,
            labelText: widget.label,
            hintStyle: widget.style,
            errorBorder: errorBorder,
            enabledBorder: widget.border,
            suffixIcon: widget.suffixIcon,
            focusedErrorBorder: errorBorder,
            focusColor: context.themeColors.primary,
            labelStyle: widget.style ?? TextStyle(),
            border: widget.border ?? const OutlineInputBorder(),
            errorStyle: TextStyle(color: context.themeColors.error),
            floatingLabelStyle: widget.style?.copyWith(
              color: context.themeColors.primary,
            ),
          ),
        ),
      );
}
