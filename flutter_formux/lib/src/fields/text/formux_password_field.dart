import 'package:flutter_formux/src/fields/text/formux_text_field.dart';
import 'package:flutter_formux/src/l10n/formux_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxPasswordField extends StatefulWidget {
  const FormuxPasswordField({
    super.key,
    this.style,
    this.label,
    this.filled,
    this.border,
    this.prefix,
    this.enabled,
    this.fillColor,
    this.onSubmitted,
    this.suffixPadding,
    this.contentPadding,
    this.floatingLabelBehavior,
    this.withLabel = true,
    this.passwordViewer = true,
    required this.input,
    required this.onChange,
  });

  final FloatingLabelBehavior? floatingLabelBehavior;
  final EdgeInsetsGeometry? contentPadding;
  final bool passwordViewer, withLabel;
  final Function(String) onChange;
  final EdgeInsets? suffixPadding;
  final VoidCallback? onSubmitted;
  final FormuxStringType input;
  final bool? enabled, filled;
  final InputBorder? border;
  final TextStyle? style;
  final Color? fillColor;
  final Widget? prefix;
  final String? label;

  @override
  State<FormuxPasswordField> createState() => _FormuxPasswordFieldState();
}

class _FormuxPasswordFieldState extends State<FormuxPasswordField> {
  late bool showPassword;

  @override
  void initState() {
    showPassword = !widget.passwordViewer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FormuxTextField(
    input: widget.input,
    style: widget.style,
    enabled: widget.enabled,
    onChange: widget.onChange,
    prefixIcon: widget.prefix,
    obscureText: !showPassword,
    onSubmitted: widget.onSubmitted,
    floatingLabelBehavior: widget.floatingLabelBehavior,
    label: widget.withLabel
        ? widget.label ?? FormuxLocalization.of(context)?.password
        : null,
    suffixIcon: widget.passwordViewer
        ? Padding(
            padding: widget.suffixPadding ?? EdgeInsets.zero,
            child: IconButton(
              onPressed: () => setState(() => showPassword = !showPassword),
              icon: Icon(
                showPassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
              ),
            ),
          )
        : null,
  );
}
