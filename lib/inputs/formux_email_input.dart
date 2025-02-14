import 'package:formux/input_type/formux_string_type.dart';
import 'package:email_validator/email_validator.dart';
import 'package:formux/mixin/translations_mixin.dart';

class FormuxEmailInput extends FormuxStringType with Translations {
  FormuxEmailInput() : super(value: '');

  @override
  void clear() {
    value = '';
    hideErrors();
  }

  @override
  void validator() {
    assertion(value.isEmpty, translations.required);

    if (value.isNotEmpty) {
      final emailValid = EmailValidator.validate(value);
      assertion(!emailValid, translations.emailFormatIncorrect);

      if (emailValid && this is FormuxEmailAbstract) {
        _validateDomains((this as FormuxEmailAbstract).allowedDomains);
      }
    }
  }

  /// Validate email domain
  void _validateDomains(List<String> allowedDomains) {
    if (allowedDomains.length == 1) {
      return assertion(
        !value.endsWith('@${allowedDomains.first}'),
        translations.emailDomainNotAllowed(allowedDomains.first),
      );
    }

    for (String domain in allowedDomains) {
      assertion(!value.endsWith('@$domain'), translations.emailDomainOutsideAllowed);
    }
  }
}

abstract class FormuxEmailAbstract extends FormuxEmailInput {
  List<String> get allowedDomains;
}
