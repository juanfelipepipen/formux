// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'formux_localization.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class FormuxLocalizationEs extends FormuxLocalization {
  FormuxLocalizationEs([String locale = 'es']) : super(locale);

  @override
  String get required => 'Campo requerido';

  @override
  String get selectCountry => 'Debe seleccionar un país';

  @override
  String get formatIncorrect => 'El formato no es correcto';

  @override
  String get emailFormatIncorrect => 'El formato no es correcto';

  @override
  String get emailDomainOutsideAllowed =>
      'El dominio del correo ingresado no se encuentra permitido';

  @override
  String get passwordConfirmationIncorrect =>
      'La contraseña de confirmación no es correcta';

  @override
  String get password => 'Contraseña';

  @override
  String get onlyNumbers => 'Solo se admiten números';

  @override
  String get dniCurpFormat => 'Formato de CURP incorrecto';

  @override
  String dateTimeAfterThan(String dateTime) {
    return 'La fecha debe ser mayor a $dateTime';
  }

  @override
  String minLength(num value) {
    return 'El valor mínimo permitido es $value';
  }

  @override
  String maxLength(num max) {
    return 'La longitud máxima es de $max carácteres';
  }

  @override
  String maxValue(num max) {
    return 'El valor máximo permitido es $max';
  }

  @override
  String fixedLength(num length) {
    return 'La longitud debe ser de $length carácteres';
  }

  @override
  String emailDomainNotAllowed(String domain) {
    return 'Solo se permite correo electrónico del dominio @$domain';
  }
}
