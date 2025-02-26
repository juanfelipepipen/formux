import 'package:formux/input_type/formux_string_type.dart';
import 'package:email_validator/email_validator.dart';
import 'package:formux/mixin/translations_mixin.dart';

class FormuxEmailInput extends FormuxStringType with Translations {
  FormuxEmailInput({super.required, super.value});

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

      if (emailValid && this is FormuxEmailAllowedDomains) {
        _validateDomains((this as FormuxEmailAllowedDomains).allowedDomains);
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

  FormuxEmailInput copy() => FormuxEmailInput(required: required, value: value);
}

abstract class FormuxEmailAllowedDomains extends FormuxEmailInput {
  List<String> get allowedDomains;
}
