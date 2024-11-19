import 'package:formux/formux.dart';

extension FormuxInputExtension on List<FormuxInput> {
  /// Loading inputs
  void loading() {
    for (FormuxInput input in this) {
      input.loading();
    }
  }

  /// Loaded inputs
  void loaded() {
    for (FormuxInput input in this) {
      input.loaded();
    }
  }
}
