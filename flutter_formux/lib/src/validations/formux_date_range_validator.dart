import 'package:flutter_formux/flutter_formux.dart';
import 'package:formux/formux.dart';
import 'package:pipen/extensions.dart';

mixin FormuxDateRangeValidator on Formux {
  FormuxDateInput get dateFrom;
  FormuxDateInput get dateTo;

  /// Custom validations
  void dateRangeValidator() {
    final datesRequired = dateFrom.value != null && dateTo.value != null;

    dateFrom.required = datesRequired;
    dateTo.required = datesRequired;

    if (datesRequired && dateTo.value != null && dateFrom.value != null) {
      dateFrom.assertion(
        dateFrom.value!.isAfter(dateTo.value!),
        formuxLocalization!.dateTimeAfterThan(dateTo.value!.toDateLabel),
      );
      showErrors();
    }
  }
}
