import 'package:flutter_formux/flutter_formux.dart';
import 'package:formux/formux.dart';
import 'package:intl/intl.dart';

class FormuxDateInput extends FormuxDateTimeType with FormuxTranslations {
  FormuxDateInput({
    super.value,
    super.required,
    this.maxDateTime,
    this.minDateTime,
    this.minNow = false,
  });

  FormuxDateInput.notRequired({
    this.maxDateTime,
    this.minDateTime,
    this.minNow = false,
    super.value,
  }) : super(required: false);

  final DateTime? maxDateTime, minDateTime;
  final bool minNow;

  @override
  void validator() {
    // Empty value
    assertion(value == null, translations.required);

    // Min date time allowed from value
    if (minDateTime != null && value != null) {
      assertion(
        value!.isBefore(minDateTime!),
        translations.dateTimeAfterThan(
          DateFormat("yyyy-MM-dd HH:mm").format(value!),
        ),
      );
    }

    // Min date time allowed is now
    if (minNow && value != null) {
      DateTime now = DateTime.now();
      assertion(
        value!.isBefore(now),
        translations.dateTimeAfterThan(
          DateFormat("yyyy-MM-dd HH:mm").format(value!),
        ),
      );
    }
  }

  @override
  void clear() {
    value = null;
    hideErrors();
  }

  /// Copy with
  FormuxDateInput copyWith({DateTime? value}) =>
      FormuxDateInput(value: value ?? this.value, required: required);
}
