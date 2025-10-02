import 'package:flutter/material.dart';
import 'package:flutter_formux/src/components/container/formux_field_spacer.dart';
import 'package:pipen/components.dart';
import 'package:pipen/extensions.dart';
import 'package:formux/formux.dart';

class FormuxInputContainer extends StatelessWidget {
  const FormuxInputContainer({
    super.key,
    this.label,
    this.child,
    this.onTap,
    this.style,
    this.border,
    this.filled,
    this.enabled,
    this.fillColor,
    this.suffixIcon,
    this.errorBorder,
    this.contentPadding,
    required this.input,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
  });

  final FloatingLabelBehavior floatingLabelBehavior;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border, errorBorder;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final FormuxInput input;
  final TextStyle? style;
  final Color? fillColor;
  final Widget? child;
  final bool? enabled;
  final String? label;
  final bool? filled;

  String? get errorText => input.display ? input.error : null;

  bool get hasError => errorText != null;
  @override
  Widget build(BuildContext context) => FormuxFieldSpacer(
    child: PipenGestureTap(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          filled: filled,
          fillColor: fillColor,
          errorText: errorText,
          enabledBorder: border,
          suffixIcon: suffixIcon,
          enabled: enabled ?? true,
          contentPadding: contentPadding,
          focusedErrorBorder: errorBorder,
          floatingLabelBehavior: floatingLabelBehavior,
          border: context.theme.inputDecorationTheme.border,
          errorStyle: TextStyle(color: context.themeColors.error),
          errorBorder: context.theme.inputDecorationTheme.errorBorder,
          focusedBorder: context.theme.inputDecorationTheme.focusedBorder,
          floatingLabelStyle:
              context.theme.inputDecorationTheme.floatingLabelStyle,
          labelStyle: input.display
              ? context.theme.inputDecorationTheme.hintStyle
              : context.theme.inputDecorationTheme.hintStyle,
        ),
        child: child,
      ),
    ),
  );
}
