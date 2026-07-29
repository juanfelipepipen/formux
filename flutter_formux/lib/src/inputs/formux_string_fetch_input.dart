import 'package:flutter_formux/flutter_formux.dart';

class FormuxStringFetchInput extends FormuxFetcherInput<String>
    with FormuxTranslations {
  FormuxStringFetchInput({
    super.required,
    this.length,
    this.fetcher,
    super.value,
    int? maxLength,
    List<FormuxStringInputValidations>? validations,
  }) : validations = validations ?? [],
       maxLength = maxLength ?? 255;

  factory FormuxStringFetchInput.notRequired({
    String? value,
    int? length,
    int? maxLength,
    Future<List<String>> Function()? fetcher,
  }) => FormuxStringFetchInput(
    value: value,
    length: length,
    fetcher: fetcher,
    maxLength: maxLength,
    required: false,
  );

  final List<FormuxStringInputValidations> validations;
  final int maxLength;
  final int? length;

  @override
  void validator() {
    assertion(value?.isEmpty == true || value == null, translations.required);

    if (value?.length != null) {
      assertion(value!.length > maxLength, translations.fixedLength(maxLength));
    }

    if (value != null) {
      if (validations.contains(FormuxStringInputValidations.onlyAlphanumeric)) {
        final regex = RegExp(r'^[a-zA-Z0-9\s]+$');
        assertion(!regex.hasMatch(value!), translations.onlyAlphanumeric);
      }
    }
  }

  @override
  void clear({bool? required}) {
    value = '';
    this.required = required ?? this.required;
    hideErrors();
  }

  /// Set value from string nullable
  void setFromNullable(String? value) {
    this.value = value ?? '';
  }

  FormuxStringFetchInput copyWith({
    int? length,
    String? value,
    bool? required,
    int? maxLength,
    List<FormuxStringInputValidations>? validations,
  }) => .new(
    value: value ?? this.value,
    length: length ?? this.length,
    required: required ?? this.required,
    maxLength: maxLength ?? this.maxLength,
    validations: validations ?? this.validations,
  );

  @override
  Future<List<String>> Function()? fetcher;
}
