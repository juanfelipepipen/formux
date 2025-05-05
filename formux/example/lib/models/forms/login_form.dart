import 'package:formux/formux.dart';

class LoginForm extends Formux {
  FormuxStringInput email = FormuxStringInput();
  FormuxStringInput password = FormuxStringInput();

  @override
  List<FormuxInput> get inputs => [email, password];
}
