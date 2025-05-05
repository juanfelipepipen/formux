import 'package:formux/src/formux.dart';

abstract class FormuxIntegerType extends FormuxInput<int?> {
  FormuxIntegerType({required this.items, super.value, super.required});

  List<int> items;

  @override
  String valueToString() {
    return value != null ? value.toString() : '';
  }
}
