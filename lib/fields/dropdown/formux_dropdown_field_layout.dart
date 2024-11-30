import 'package:pipen/components/builders/builder/pipen_builder_when.dart';
import 'package:formux/fields/dropdown/state/dropdown_cubit.dart';
import 'package:pipen/bloc/builder/bloc_builder_fetch.dart';
import 'package:formux/inputs/formux_input_valuable.dart';
import 'package:pipen/components/row/pipen_row.dart';
import 'package:pipen/abstract/loading_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen/valuable/valuable.dart';
import 'package:flutter/material.dart';

class FormuxDropdownFieldLayout extends StatefulWidget {
  const FormuxDropdownFieldLayout({super.key, required this.input, this.label, this.onChange});

  final Function(Valuable)? onChange;
  final FormuxInputValuable input;
  final String? label;

  @override
  State<FormuxDropdownFieldLayout> createState() => _FormuxDropdownFieldLayoutState();
}

class _FormuxDropdownFieldLayoutState extends State<FormuxDropdownFieldLayout> {
  Valuable? value;

  @override
  void initState() {
    super.initState();
    if (widget.input.fetch != null) {
      context.read<DropdownCubit>().load(widget.input.fetch);
    } else {
      context.read<DropdownCubit>().empty();
    }
  }

  @override
  void didUpdateWidget(covariant FormuxDropdownFieldLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    context.read<DropdownCubit>().load(widget.input.fetch);
  }

  void onChange(Valuable? newValue) {
    if (newValue != null) {
      widget.onChange?.call(newValue);
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilderFetch<DropdownCubit, ValuableList>(
        builder: (context, state, bloc) => PipenRow(
          vertical: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButtonFormField<Valuable>(
                isExpanded: true,
                onChanged: onChange,
                value: widget.input.value,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: widget.label != null ? Text(widget.label!) : null,
                ),
                items: [
                  ...bloc.items.map<DropdownMenuItem<Valuable>>(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.title),
                    ),
                  )
                ],
              ),
            ),
            When<LoadingState>(
              value: state,
              child: (_) => const Padding(
                padding: EdgeInsets.only(left: 20),
                child: SizedBox.square(
                  dimension: 25,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      );
}
