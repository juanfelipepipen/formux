class InputError {
  InputError({required this.field, required this.errors});

  factory InputError.fromList({required String field, required List<dynamic> errors}) =>
      InputError(field: field, errors: errors.map((e) => e.toString()).toList());

  List<String> errors;
  String field;
}
