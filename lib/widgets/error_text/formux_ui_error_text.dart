import 'package:pipen/components/transitions/slice_from_up/pipen_slice_from_up.dart';
import 'package:pipen/formux/abstract/formux_input.dart';
import 'package:flutter/material.dart';

class FormuxUiErrorText extends StatefulWidget {
  const FormuxUiErrorText({
    super.key,
    this.fontWeight,
    this.letterSpacing,
    this.errors = true,
    this.color = Colors.red,
    this.align = TextAlign.left,
    required this.input,
  });

  final FontWeight? fontWeight;
  final double? letterSpacing;
  final FormuxInput input;
  final TextAlign align;
  final bool errors;
  final Color color;

  @override
  State<FormuxUiErrorText> createState() => _FormuxUiErrorTextState();
}

class _FormuxUiErrorTextState extends State<FormuxUiErrorText> {
  String? error;

  @override
  void initState() {
    error = widget.input.error;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormuxUiErrorText oldWidget) {
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
                  color: widget.color,
                  fontWeight: widget.fontWeight,
                  letterSpacing: widget.letterSpacing,
                ),
              ),
            )
          ],
        ),
      );
}
