import 'package:formux/fields/dropdown/fetcher/state/formux_dropdown_fetch_listener.dart';
import 'package:formux/fields/dropdown/fetcher/state/formux_dropdown_fetch_cubit.dart';
import 'package:formux/inputs/formux_valuable_fetch_input.dart';
import 'package:pipen/bloc/listener/bloc_listener_fetch.dart';
import 'package:pipen/bloc/builder/bloc_builder_fetch.dart';
import 'package:formux/widgets/loader/field_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen/cubit/cubit_fetch.dart';
import 'package:pipen/valuable/valuable.dart';
import 'package:flutter/material.dart';

part 'layout.dart';

class FormuxDropdownFetcherField extends StatelessWidget {
  const FormuxDropdownFetcherField({
    super.key,
    this.state,
    this.label,
    required this.input,
    required this.onChange,
  });

  final FormuxValuableFetchInput input;
  final OnValuableEventChange onChange;
  final dynamic state;
  final String? label;

  @override
  Widget build(BuildContext context) => BlocProvider<FormuxDropdownFetchCubit>(
        create: (_) => FormuxDropdownFetchCubit(),
        child: BlocListenerFetch<FormuxDropdownFetchCubit, ValuableList>(
          listener: FormuxDropdownFetchListener(onChange: onChange),
          child: Layout(input: input, label: label, onChange: onChange),
        ),
      );
}
