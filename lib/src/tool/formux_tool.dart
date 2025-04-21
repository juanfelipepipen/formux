import 'package:formux/src/formux.dart';

class FormuxTool {
  static void loading(List<dynamic> inputs) {
    for (var input in inputs) {
      if (input is FormuxInput) {}
    }
  }
}
