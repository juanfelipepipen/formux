import 'package:formux/l10n/formux_localization.dart';

FormuxLocalization? formuxLocalization;

mixin Translations {
  FormuxLocalization get translations {
    if (formuxLocalization == null) {
      throw Exception(
          'Need set formuxLocalization with current localization using FormuxLocalization.of(context)');
    }
    return formuxLocalization!;
  }
}
