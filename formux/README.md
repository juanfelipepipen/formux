# formux

Form state and validation primitives for Dart and Flutter. This package contains no Flutter widgets. The companion package [flutter_formux](https://pub.dev/packages/flutter_formux) provides concrete inputs and UI components.

## Install

```sh
dart pub add formux
```

For Flutter widgets, also install `flutter_formux`:

```sh
flutter pub add flutter_formux
```

## Quick example

```dart
import 'package:formux/formux.dart';

class NameInput extends FormuxStringType {
  NameInput({super.value});

  @override
  void validator() => assertion(value.trim().isEmpty, 'Enter a name');

  @override
  void clear() {
    value = '';
    hideErrors();
  }
}

class ProfileForm extends Formux<ProfileForm> {
  ProfileForm({String name = ''}) : name = NameInput(value: name);

  final NameInput name;

  @override
  List<FormuxInput> get inputs => [name];

  @override
  ProfileForm copy() => ProfileForm(name: name.value);
}

void main() {
  final form = ProfileForm();
  print(form.passed); // false: the required name is empty.
  print(form.name.display); // false: initial errors are hidden.

  form.valid(); // Shows errors when validation fails.
  print(form.name.error); // Enter a name

  form.name.value = 'Ada'; // Revalidates this input.
  print(form.valid()); // true
}
```

This example copies the input value only. If a form is used as a `CubitForm` state, its copy implementation must deliberately handle the validation and display state its UI needs.

## Documentation

- [Documentation index](docs/README.md)
- [Core inputs and forms](docs/core.md)
- [Cubit and server errors](docs/state-and-errors.md)
- [Flutter inputs and components](docs/flutter-components.md)
- [Improvement proposals](docs/proposals/core-api-and-documentation.md)

Licensed under Apache 2.0; see [LICENSE](LICENSE).
