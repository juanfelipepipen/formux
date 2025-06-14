import 'package:flutter_formux/src/abstract/state/dropdown_fetcher_listener.dart';
import 'package:flutter_formux/src/abstract/state/dropdown_fetcher_cubit.dart';
import 'package:flutter_formux/src/inputs/formux_valuable_fetch_input.dart';
import 'package:flutter_formux/src/widgets/loader/field_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:pipen/components.dart';
import 'package:pipen/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pipen/valuable.dart';
import 'package:formux/formux.dart';

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
