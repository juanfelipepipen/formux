part of 'formux_dropdown_fetcher_field.dart';

class FormuxDropdownIntegerFetchField extends StatelessWidget {
  const FormuxDropdownIntegerFetchField({super.key, required this.input, this.label});

  final FormuxIntegerInput input;
  final String? label;

  @override
  Widget build(BuildContext context) => FormuxDropdownFieldBuilder(input: input, onChange: (_) {});
}
