import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:flutter_formux/src/components/builder/fetcher_field_builder.dart';
import 'package:flutter_formux/src/components/builder/width_mode_builder.dart';
import 'package:flutter_formux/src/components/on_init.dart';
import 'package:flutter_formux/src/state/dropdown/state/fetch_field_cubit.dart';
import 'package:formux/formux.dart';
import 'package:pipen/components.dart';
import 'package:pipen_bloc/pipen_bloc.dart';

typedef DropdownBuilderParams<T> =
    ({
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
  State<FormuxDropdownFieldBuilder<T>> createState() => _FormuxDropdownFieldBuilderState<T>();
}

class _FormuxDropdownFieldBuilderState<T> extends State<FormuxDropdownFieldBuilder<T>> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => FetcherFieldBuilder<T>(
    onItems: widget.field.onItems,
    builder:
        (context, state, bloc) => OnInit(
          callback: () => context.read<FetchFieldCubit<T>>().load(widget.fetcher),
          child: WidthModeBuilder(
            builder:
                (context, width) => DropdownMenu<T>(
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
                    FetchPending() => null,
                    FetchSuccess() => null,
                    FetchLoading() => FormuxFieldSpinner(),
                    FetchFail() => IconButton(icon: Icon(Icons.refresh), onPressed: bloc.refresh),
                  },
                  dropdownMenuEntries:
                      widget.field.items
                          .map((e) => DropdownMenuEntry<T>(value: e, label: widget.field.lister(e)))
                          .toList(),
                ),
          ),
        ),
  );
}
