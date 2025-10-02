import 'package:flutter/cupertino.dart';
import 'package:formux/formux.dart';

class FormuxControllerContainer extends StatefulWidget {
  const FormuxControllerContainer({
    super.key,
    required this.input,
    required this.builder,
  });

  final Widget Function(BuildContext, TextEditingController, String?) builder;
  final FormuxInput input;

  @override
  State<FormuxControllerContainer> createState() =>
      _FormuxControllerContainerState();
}

class _FormuxControllerContainerState extends State<FormuxControllerContainer> {
  late TextEditingController controller;

  String? get errorText => widget.input.display ? widget.input.error : null;

  @override
  void initState() {
    controller = TextEditingController();
    updateText();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormuxControllerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateText();
  }

  /// Compare and update text in text controller
  void updateText() {
    if (widget.input.valueToString() != controller.text) {
      setState(() => controller.text = widget.input.valueToString());
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, controller, errorText);
}
