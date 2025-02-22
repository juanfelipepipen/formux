import 'package:pipen/components/gesture/pipen_gesture_tap.dart';
import 'package:pipen/extensions/context_extension.dart';
import 'package:pipen/components/gap/pipen_gap.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxInputContainer extends StatefulWidget {
  const FormuxInputContainer({
    super.key,
    this.child,
    this.onTap,
    this.style,
    this.border,
    this.errorBorder,
    this.suffixIcon,
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
  final String label;


  String? get errorText => input.display ? input.error : null;

  bool get hasError => errorText != null;

  @override
  State<FormuxInputContainer> createState() => _FormuxInputContainerState();
}

class _FormuxInputContainerState extends State<FormuxInputContainer> {
  @override
  Widget build(BuildContext context) => PipenGap.small(
        child: PipenGestureTap(
          onTap: widget.onTap,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.label,
              errorText: widget.errorText,
              enabledBorder: widget.border,
              suffixIcon: widget.suffixIcon,
              contentPadding: widget.contentPadding,
              focusedErrorBorder: widget.errorBorder,
              border: context.theme.inputDecorationTheme.border,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              errorStyle: TextStyle(color: context.themeColors.error),
              errorBorder: context.theme.inputDecorationTheme.errorBorder,
              focusedBorder: context.theme.inputDecorationTheme.focusedBorder,
              floatingLabelStyle: widget.style?.copyWith(
                color: context.themeColors.primary,
              ),
              labelStyle: widget.input.display
                  ? context.theme.inputDecorationTheme.hintStyle
                  : context.theme.inputDecorationTheme.hintStyle,
            ),
            child: widget.child,
          ),
        ),
      );
}
