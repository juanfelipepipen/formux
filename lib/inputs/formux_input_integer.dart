import 'package:formux/formux.dart';

abstract class FormuxInputInteger extends FormuxInput<int?> {
  FormuxInputInteger({required this.items, super.value, super.required});

  List<int> items;
}
