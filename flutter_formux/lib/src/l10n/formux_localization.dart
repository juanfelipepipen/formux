import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'formux_localization_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of FormuxLocalization
/// returned by `FormuxLocalization.of(context)`.
///
/// Applications need to include `FormuxLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/formux_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FormuxLocalization.localizationsDelegates,
///   supportedLocales: FormuxLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the FormuxLocalization.supportedLocales
/// property.
abstract class FormuxLocalization {
  FormuxLocalization(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FormuxLocalization? of(BuildContext context) {
    return Localizations.of<FormuxLocalization>(context, FormuxLocalization);
  }

  static const LocalizationsDelegate<FormuxLocalization> delegate =
      _FormuxLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @required.
  ///
  /// In es, this message translates to:
  /// **'Campo requerido'**
  String get required;

  /// No description provided for @selectCountry.
  ///
  /// In es, this message translates to:
  /// **'Debe seleccionar un país'**
  String get selectCountry;

  /// No description provided for @formatIncorrect.
  ///
  /// In es, this message translates to:
  /// **'El formato no es correcto'**
  String get formatIncorrect;

  /// No description provided for @emailFormatIncorrect.
  ///
  /// In es, this message translates to:
  /// **'El formato no es correcto'**
  String get emailFormatIncorrect;

  /// No description provided for @emailDomainOutsideAllowed.
  ///
  /// In es, this message translates to:
  /// **'El dominio del correo ingresado no se encuentra permitido'**
  String get emailDomainOutsideAllowed;

  /// No description provided for @passwordConfirmationIncorrect.
  ///
  /// In es, this message translates to:
  /// **'La contraseña de confirmación no es correcta'**
  String get passwordConfirmationIncorrect;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @dateTimeAfterThan.
  ///
  /// In es, this message translates to:
  /// **'La fecha debe ser mayor a {dateTime}'**
  String dateTimeAfterThan(String dateTime);

  /// No description provided for @minLength.
  ///
  /// In es, this message translates to:
  /// **'El valor mínimo permitido es {value}'**
  String minLength(num value);

  /// No description provided for @maxLength.
  ///
  /// In es, this message translates to:
  /// **'La longitud máxima es de {max} carácteres'**
  String maxLength(num max);

  /// No description provided for @fixedLength.
  ///
  /// In es, this message translates to:
  /// **'La longitud debe ser de {length} carácteres'**
  String fixedLength(num length);

  /// No description provided for @emailDomainNotAllowed.
  ///
  /// In es, this message translates to:
  /// **'Solo se permite correo electrónico del dominio @{domain}'**
  String emailDomainNotAllowed(String domain);
}

class _FormuxLocalizationDelegate
    extends LocalizationsDelegate<FormuxLocalization> {
  const _FormuxLocalizationDelegate();

  @override
  Future<FormuxLocalization> load(Locale locale) {
    return SynchronousFuture<FormuxLocalization>(
      lookupFormuxLocalization(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_FormuxLocalizationDelegate old) => false;
}

FormuxLocalization lookupFormuxLocalization(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return FormuxLocalizationEs();
  }

  throw FlutterError(
    'FormuxLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
