import 'package:formux/src/exceptions/formux_failed_pass_exception.dart';

part 'formux_input.dart';

abstract class Formux<F> {
  /// Constructor
  Formux({bool loading = false}) {
    if (loading) {
      this.loading();
    }
  }

  /// [Abstract] Form id
  String? id;

  /// [Abstract] Form inputs
  List<FormuxInput> get inputs;

  /// [Getter] All inputs passed
  bool get passed => inputs.every((input) => input.required ? input.pass : true);

  /// All inputs is loading
  bool get isLoading => inputs.every((input) => input.isLoading);

  /// Form has id assigned
  bool get hasId => id != null;

  /// Check if form pass validations
  void pass({Function()? onPassed}) {
    bool pass = valid();

    if (!pass && onPassed == null) {
      throw FormuxFailedPassException();
    }

    if (pass && onPassed != null) {
      onPassed();
    }
  }

  /// Validate inputs
  Formux validate() {
    for (FormuxInput input in inputs) {
      input.validate();
    }
    return this;
  }

  /// Check if form is invalid, show
  /// errors and return status
  bool valid() {
    bool pass = passed;
    if (!pass) {
      showErrors();
    }
    return pass;
  }

  /// Is loading form
  void loading() {
    for (FormuxInput input in inputs) {
      input.loading();
    }
  }

  /// Is loading form
  void loaded() {
    for (FormuxInput input in inputs) {
      input.loaded();
    }
  }

  /// Hide input errors
  void hideErrors() {
    for (FormuxInput input in inputs) {
      input.hideErrors();
    }
  }

  /// Show errors
  void showErrors() {
    for (FormuxInput input in inputs) {
      input.showErrors();
    }
  }

  /// Map inputs and print
  void toMap() {
    Map<String, dynamic> values = {};
    int i = 0;

    for (FormuxInput input in inputs) {
      i++;
      values[i.toString()] = getInputValue(input.value);
    }
  }

  /// Get input value in string
  String getInputValue(dynamic value) {
    return value.toString();
  }
}
