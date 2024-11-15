import 'package:pipen/formux/abstract/formux_input.dart';

extension FormuxInputListExtension on List {
  /// Loading inputs
  void loading() {
    for (var input in this) {
      if (input is FormuxInput) {
        input.loading();
      }
    }
  }

  /// Loaded inputs
  void loaded() {
    for (var input in this) {
      if (input is FormuxInput) {
        input.loaded();
      }
    }
  }

  /// Clear inputs
  void clearInputs() {
    for (var input in this) {
      if (input is FormuxInput) {
        input.clear();
      }
    }
  }

  /// Required
  void required([bool isRequired = true]) {
    for (var input in this) {
      if (input is FormuxInput) {
        input.required = isRequired;
        input.clear();
      }
    }
  }

  /// Not required
  void notRequired() => required(false);
}
