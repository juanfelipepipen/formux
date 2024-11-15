import 'package:pipen/components/transitions/slice_from_up/pipen_slice_from_up.dart';
import 'package:pipen/extensions/context_extension.dart';
import 'package:pipen/formux/abstract/formux_input.dart';
import 'package:flutter/material.dart';

class FormuxErrorText extends StatefulWidget {
  const FormuxErrorText({
    super.key,
    required this.input,
    this.color,
    this.fontWeight,
    this.letterSpacing,
    this.errors = true,
    this.align = TextAlign.left,
  });

  final FontWeight? fontWeight;
  final double? letterSpacing;
  final FormuxInput input;
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
        child: Row(
          mainAxisAlignment: switch (widget.align) {
            TextAlign.right => MainAxisAlignment.end,
            TextAlign.center => MainAxisAlignment.center,
            _ => MainAxisAlignment.start
          },
          children: [
            Expanded(
              child: Text(
                error ?? '',
                textAlign: widget.align,
                style: TextStyle(
                  fontWeight: widget.fontWeight,
                  letterSpacing: widget.letterSpacing,
                  color: widget.color ?? context.themeColors.error,
                ),
              ),
            )
          ],
        ),
      );
}