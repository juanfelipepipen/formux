import 'package:formux/formux.dart';

abstract class FormuxCopy<F extends Formux> {
  /// Copy form properties
  F copy();
}
