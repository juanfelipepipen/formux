import 'package:pipen/extensions/context_extension.dart';
import 'package:formux/inputs/formux_input_string.dart';
import 'package:flutter/material.dart';

class FormuxTextField extends StatefulWidget {
  const FormuxTextField({
    super.key,
    this.minLines,
    this.obscureText = false,
    required this.label,
    required this.input,
    required this.onChange,
  });

  const FormuxTextField.obscureText({
    super.key,
    this.minLines,
    required this.label,
    required this.input,
    required this.onChange,
  }) : obscureText = true;

  const FormuxTextField.textArea({
    super.key,
    this.minLines = 3,
    this.obscureText = false,
    required this.label,
    required this.input,
    required this.onChange,
  });

  final FormuxInputString input;
  final Function(String) onChange;
  final bool obscureText;
  final int? minLines;
  final String label;

  @override
  State<FormuxTextField> createState() => _FormuxTextFieldState();
}

class _FormuxTextFieldState extends State<FormuxTextField> {
  late TextEditingController controller;

  String? get errorText => widget.input.display ? widget.input.error : null;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    updateText();
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
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 10,
        child: TextField(
          controller: controller,
          minLines: widget.minLines,
          onChanged: widget.onChange,
          maxLines: widget.minLines ?? 1,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            errorText: errorText,
            labelText: widget.label,
            border: const OutlineInputBorder(),
            focusColor: context.themeColors.primary,
            hintStyle: TextStyle(color: context.themeColors.error),
            errorStyle: TextStyle(color: context.themeColors.error),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.themeColors.error, width: 2.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.themeColors.error, width: 2.0),
            ),
          ),
        ),
      );
}
