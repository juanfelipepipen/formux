import 'package:flutter_formux/src/inputs/formux_valuable_fetch_input.dart';
import 'package:flutter_formux/src/widgets/loader/field_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:pipen/components.dart';
import 'package:pipen/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pipen/valuable.dart';
import 'package:formux/formux.dart';

import '../fetcher/formux_dropdown_fetcher_field.dart';

part 'layout.dart';

class FormuxDropdownFieldBuilder extends StatelessWidget {
  const FormuxDropdownFieldBuilder({
    super.key,
    this.state,
    this.label,
    this.fetcher,
    required this.input,
    required this.onChange,
  });

  final ValuableListFetchCallback? fetcher;
  final OnValuableEventChange onChange;
  final FormuxInput input;
  final dynamic state;
  final String? label;

  @override
  Widget build(BuildContext context) => BlocProvider<DropdownCubit>(
    create: (_) => DropdownCubit(),
    child: BlocListenerFetch<DropdownCubit, ValuableList>(
      listener: DropdownListener(onChange: onChange),
      child: _Layout(input: input, label: label, onChange: onChange, items: []),
    ),
  );
}
