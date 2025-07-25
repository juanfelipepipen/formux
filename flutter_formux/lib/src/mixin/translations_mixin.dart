import 'package:flutter_formux/src/l10n/formux_localization.dart';

FormuxLocalization? formuxLocalization;

mixin FormuxTranslations {
  FormuxLocalization get translations {
    if (formuxLocalization == null) {
      throw Exception(
        'Need set formuxLocalization with current localization using FormuxLocalization.of(context)',
      );
    }
    return formuxLocalization!;
  }
}
