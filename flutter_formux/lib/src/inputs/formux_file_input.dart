import 'package:flutter_formux/flutter_formux.dart';
import 'package:file_picker/file_picker.dart';
import 'package:formux/formux.dart';

class FormuxFileInput extends FormuxInput<PlatformFile?> with FormuxTranslations {
  FormuxFileInput() : super(value: null);

  @override
  void validator() {
    assertion(value == null, translations.required);
  }

  @override
  void clear() {
    value = null;
    errors = false;
  }
}
