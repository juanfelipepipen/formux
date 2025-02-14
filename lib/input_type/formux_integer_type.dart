import 'package:formux/formux.dart';

abstract class FormuxIntegerType extends FormuxInput<int?> {
  FormuxIntegerType({required this.items, super.value, super.required});

  List<int> items;
}
