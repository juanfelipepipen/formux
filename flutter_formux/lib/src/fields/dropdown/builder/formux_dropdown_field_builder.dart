import 'package:flutter_formux/src/components/container/formux_field_spacer.dart';
import 'package:flutter_formux/src/components/builder/width_mode_builder.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formux/formux.dart';

typedef DropdownBuilderParams<T> = ({
  List<T> items,
  Function(T? value) onChange,
  Function(List<T> items) onItems,
  String Function(T value) lister,
  T? Function(List<T> items) initialSelector,
});

class FormuxDropdownFieldBuilder<T> extends StatefulWidget {
  const FormuxDropdownFieldBuilder({
    super.key,
    this.value,
    this.state,
    this.label,
    this.fetcher,
    required this.field,
    required this.input,
  });

  final Future<List<T>> Function()? fetcher;
  final DropdownBuilderParams<T> field;
  final FormuxInput<T?> input;
  final String? label, value;
  final dynamic state;

  @override
  State<FormuxDropdownFieldBuilder<T>> createState() =>
      _FormuxDropdownFieldBuilderState<T>();
}

class _FormuxDropdownFieldBuilderState<T>
    extends State<FormuxDropdownFieldBuilder<T>> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant FormuxDropdownFieldBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null) {
      setState(() => controller.text = '');
    }
  }

  @override
  Widget build(BuildContext context) => FetcherFieldBuilder<T>(
    fetcher: widget.fetcher,
    onItems: widget.field.onItems,
    builder: (context, state, bloc) => FormuxFieldSpacer(
      child: WidthModeBuilder(
        builder: (context, width) => DropdownMenu<T>(
          width: width,
          enableFilter: true,
          enableSearch: true,
          controller: controller,
          requestFocusOnTap: true,
          onSelected: widget.field.onChange,
          label: widget.label != null ? Text(widget.label!) : null,
          errorText: widget.input.display ? widget.input.error : null,
          initialSelection: widget.field.initialSelector(widget.field.items),
          trailingIcon: switch (state) {
            FetchLoading() => FormuxFieldSpinner(),
            FetchFail() => IconButton(
              icon: Icon(Icons.refresh),
              onPressed: bloc.refresh,
            ),
            _ => null,
          },
          dropdownMenuEntries: widget.field.items
              .map(
                (e) => DropdownMenuEntry<T>(
                  value: e,
                  label: widget.field.lister(e),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
