import 'package:formux/abstract/state/dropdown_fetcher_listener.dart';
import 'package:formux/abstract/state/dropdown_fetcher_cubit.dart';
import 'package:formux/abstract/state/dropdown_input_event.dart';
import 'package:formux/inputs/formux_valuable_fetch_input.dart';
import 'package:pipen/bloc/listener/bloc_listener_fetch.dart';
import 'package:pipen/bloc/builder/bloc_builder_fetch.dart';
import 'package:formux/widgets/loader/field_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen/cubit/cubit_fetch.dart';
import 'package:pipen/valuable/valuable.dart';
import 'package:flutter/material.dart';

part 'layout.dart';

typedef DropdownCubit = DropdownFetcherCubit<Valuable>;
typedef DropdownListener = DropdownFetcherListener<Valuable>;
typedef DropdownBuilder = BlocBuilderFetch<DropdownCubit, ValuableList>;

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
  Widget build(BuildContext context) => BlocProvider<DropdownCubit>(
        create: (_) => DropdownCubit(),
        child: BlocListenerFetch<DropdownCubit, ValuableList>(
          listener: DropdownListener(onChange: onChange),
          child: Layout(input: input, label: label, onChange: onChange),
        ),
      );
}
