import 'package:flutter_formux/src/components/container/formux_double_controller_container.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:flutter/material.dart';

class FormuxDoubleField extends StatelessWidget {
  const FormuxDoubleField({
    super.key,
    this.label,
    this.state,
    this.enabled,
    this.errors = true,
    required this.input,
    required this.onChange,
    this.symbolTextField = true,
  });

  const FormuxDoubleField.disabled({
    super.key,
    this.label,
    this.state,
    this.errors = true,
    required this.input,
    required this.onChange,
    this.symbolTextField = true,
  }) : enabled = false;

  final Function(double value) onChange;
  final bool symbolTextField, errors;
  final FormuxDoubleInput input;
  final FetchState? state;
  final String? label;
  final bool? enabled;

  bool get _isLoading => state is FetchLoading;

  @override
  Widget build(BuildContext context) => Skeleton(
    isLoading: _isLoading,
    skeleton: _field(context, true),
    child: _field(context),
  );

  /// Get field component
  Widget _field(
    BuildContext context, [
    bool skeleton = false,
  ]) => FormuxDoubleControllerContainer(
    input: input,
    builder: (context, controller) => FormuxTextField(
      label: label,
      input: input,
      filled: skeleton,
      enabled: enabled,
      controller: controller,
      // prefix: Padding(padding: EdgeInsets.only(right: 4), child: Text(r'$')),
      onChange: (e) {
        onChange.call(controller.doubleValue);
      },
    ),
  );
}
