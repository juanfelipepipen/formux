import 'package:pipen/components/gesture/pipen_gesture_tap.dart';
import 'package:pipen/extensions/context_extension.dart';
import 'package:pipen/components/gap/pipen_gap.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxInputContainer extends StatelessWidget {
  const FormuxInputContainer({
    super.key,
    this.child,
    this.onTap,
    this.style,
    this.border,
    this.enabled,
    this.suffixIcon,
    this.errorBorder,
    this.contentPadding,
    required this.label,
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
  final Widget? child;
  final bool? enabled;
  final String label;

  String? get errorText => input.display ? input.error : null;

  bool get hasError => errorText != null;
  @override
  Widget build(BuildContext context) => PipenGap.small(
    child: PipenGestureTap(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
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
          floatingLabelStyle: context.theme.inputDecorationTheme.floatingLabelStyle,
          labelStyle:
              input.display
                  ? context.theme.inputDecorationTheme.hintStyle
                  : context.theme.inputDecorationTheme.hintStyle,
        ),
        child: child,
      ),
    ),
  );
}
