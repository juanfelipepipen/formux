import 'package:pipen/components.dart';
import 'package:pipen/extensions.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

class FormuxErrorText extends StatefulWidget {
  const FormuxErrorText({
    super.key,
    this.color,
    this.style,
    this.padding,
    this.fontWeight,
    this.letterSpacing,
    this.errors = true,
    required this.input,
    this.align = TextAlign.left,
  });

  final FontWeight? fontWeight;
  final double? letterSpacing;
  final EdgeInsets? padding;
  final FormuxInput input;
  final TextStyle? style;
  final TextAlign align;
  final Color? color;
  final bool errors;

  @override
  State<FormuxErrorText> createState() => _FormuxErrorTextState();
}

class _FormuxErrorTextState extends State<FormuxErrorText> {
  String? error;

  @override
  void initState() {
    error = widget.input.error;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormuxErrorText oldWidget) {
    didCompareError();
    super.didUpdateWidget(oldWidget);
  }

  @protected
  void didCompareError() {
    if (widget.input.error != error && widget.input.error != null) {
      setState(() => error = widget.input.error);
    }
  }

  @override
  Widget build(BuildContext context) => PipenSliceFromUp(
    show: widget.input.display && widget.errors,
    duration: const Duration(milliseconds: 400),
    child: PipenRow.expanded(
      horizontal: switch (widget.align) {
        TextAlign.right => MainAxisAlignment.end,
        TextAlign.center => MainAxisAlignment.center,
        _ => MainAxisAlignment.start,
      },
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Text(
          error ?? '',
          textAlign: widget.align,
          style:
              widget.style ??
              TextStyle(
                fontWeight: widget.fontWeight,
                letterSpacing: widget.letterSpacing,
                color: widget.color ?? context.themeColors.error,
              ),
        ),
      ),
    ),
  );
}
