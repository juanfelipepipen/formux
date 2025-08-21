import 'package:flutter/cupertino.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:flutter_formux/src/fields/dropdown/builder/formux_dropdown_field_builder.dart';
import 'package:pipen/valuable.dart';

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
  Widget build(BuildContext context) => FormuxDropdownFieldBuilder<Valuable>(
    input: input,
    state: state,
    label: label,
    fetcher: input.fetch,
    value: input.valueFromItems?.value,
    field: (
      items: input.items,
      lister: (value) => value.title,
      onItems: (items) {
        onChange(ValuableInputEvent.setItems(items));
      },
      initialSelector: (items) {
        if (input.value == null) return null;
        final index = items.indexWhere((e) => e.value == input.value!.value);
        return index == -1 ? null : items[index];
      },
      onChange: (value) {
        if (value != null) {
          onChange(ValuableInputEvent.setValue(value));
        }
      },
    ),
  );
}
