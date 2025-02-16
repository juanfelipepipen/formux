import 'package:formux/fields/text/formux_text_field.dart';
import 'package:formux/input_type/formux_string_type.dart';
import 'package:formux/l10n/formux_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormuxPasswordField extends StatefulWidget {
  const FormuxPasswordField({
    super.key,
    this.style,
    this.filled,
    this.border,
    this.fillColor,
    this.onSubmitted,
    this.contentPadding,
    required this.input,
    required this.label,
    required this.onChange,
  });

  final EdgeInsetsGeometry? contentPadding;
  final Function(String) onChange;
  final VoidCallback? onSubmitted;
  final FormuxStringType input;
  final InputBorder? border;
  final TextStyle? style;
  final Color? fillColor;
  final String? label;
  final bool? filled;

  @override
  State<FormuxPasswordField> createState() => _FormuxPasswordFieldState();
}

class _FormuxPasswordFieldState extends State<FormuxPasswordField> {
  late bool showPassword;

  @override
  void initState() {
    showPassword = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FormuxTextField.obscureText(
        input: widget.input,
        style: widget.style,
        border: widget.border,
        filled: widget.filled,
        onChange: widget.onChange,
        fillColor: widget.fillColor,
        onSubmitted: widget.onSubmitted,
        contentPadding: widget.contentPadding,
        label: widget.label ?? FormuxLocalization.of(context)!.password,
        suffixIcon: IconButton(
          onPressed: () => setState(() => showPassword = !showPassword),
          icon: Icon(showPassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
        ),
      );
}
