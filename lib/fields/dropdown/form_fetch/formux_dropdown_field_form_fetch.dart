import 'package:formux/fields/dropdown/form_fetch/state/dropdown_fetch_cubit.dart';
import 'package:formux/fields/dropdown/form_fetch/state/dropdown_listener.dart';
import 'package:pipen/components/builders/builder/pipen_builder_when.dart';
import 'package:pipen/bloc/listener/bloc_listener_fetch.dart';
import 'package:pipen/bloc/builder/bloc_builder_fetch.dart';
import 'package:formux/inputs/formux_input_valuable.dart';
import 'package:pipen/components/gap/pipen_gap.dart';
import 'package:pipen/components/row/pipen_row.dart';
import 'package:pipen/abstract/loading_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen/valuable/valuable.dart';
import 'package:flutter/material.dart';

part 'layout.dart';

class FormuxDropdownFieldFormFetch extends StatefulWidget {
  const FormuxDropdownFieldFormFetch({
    super.key,
    this.label,
    required this.input,
    required this.onChange,
  });

  final Function(Valuable?)? onChange;
  final FormuxInputValuable input;
  final String? label;

  @override
  State<FormuxDropdownFieldFormFetch> createState() => _FormuxDropdownFieldFormFetchState();
}

class _FormuxDropdownFieldFormFetchState extends State<FormuxDropdownFieldFormFetch> {
  Valuable? original;

  @override
  void initState() {
    super.initState();
    original = widget.input.value;
    widget.onChange?.call(null);
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DropdownFetchCubit(initial: original),
        child: BlocListenerFetch<DropdownFetchCubit, DropdownState>(
          listener: (context, state) => DropdownFetchListener(
            listen: (context, state),
            onChange: widget.onChange,
          ),
          child: PipenGap.small(
            child: PipenDropdownFormLayout(
              input: widget.input,
              label: widget.label,
              onChange: widget.onChange,
            ),
          ),
        ),
      );
}
