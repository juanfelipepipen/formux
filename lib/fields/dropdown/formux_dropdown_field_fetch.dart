import 'package:formux/fields/dropdown/formux_dropdown_field_layout.dart';
import 'package:formux/fields/dropdown/state/dropdown_cubit.dart';
import 'package:pipen/bloc/listener/bloc_listener_fetch.dart';
import 'package:formux/inputs/formux_input_valuable.dart';
import 'package:pipen/components/gap/pipen_gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen/cubit/cubit_fetch.dart';
import 'package:pipen/valuable/valuable.dart';
import 'package:flutter/material.dart';

class FormuxDropdownFieldFetch extends StatefulWidget {
  const FormuxDropdownFieldFetch({super.key, required this.input, this.label, required this.onChange});

  final Function(Valuable?)? onChange;
  final FormuxInputValuable input;
  final String? label;

  @override
  State<FormuxDropdownFieldFetch> createState() => _FormuxDropdownFieldFetchState();
}

class _FormuxDropdownFieldFetchState extends State<FormuxDropdownFieldFetch> {
  Valuable? original;

  @override
  void initState() {
    super.initState();
    original = widget.input.value;
    widget.onChange?.call(null);
  }

  /// Listen dropdown state changes
  void listener(BuildContext context, FetchState state) {
    bool fetched = context.read<DropdownCubit>().fetcher != null;

    if (state is FetchSuccess && widget.input.value == null && fetched && original != null) {
      try {
        Valuable value = (state.result).firstWhere((e) => e.value == original?.value);
        widget.onChange?.call(value);
      } catch (_) {
        original = null;
        widget.onChange?.call(null);
      }
    }

    if (state is FetchLoading) {
      widget.onChange?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DropdownCubit(),
        child: BlocListenerFetch<DropdownCubit, ValuableList>(
          listener: listener,
          child: PipenGap.small(
            child: FormuxDropdownFieldLayout(
              input: widget.input,
              label: widget.label,
              onChange: widget.onChange,
            ),
          ),
        ),
      );
}
