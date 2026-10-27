# Cubit state and server errors

Import `package:formux/formux.dart`. This guide describes the current behavior of `CubitForm` and the error models. It does not prescribe a new immutable-state contract.

## `CubitForm<F extends Formux>`

Subclass `CubitForm<F>` to keep a form as BLoC state. In addition to `Formux.copy()`, the state must implement `FormuxCopy<F>` for `CubitForm`'s runtime copy check. Without it, `_copyForm()` throws an exception.

`validate(onValid)` calls `state.valid()`, invokes `onValid(state)` when valid, then emits a copy of the current form. The callback runs **before** that emission. `state.valid()` may also make errors visible on the existing state before the copy is emitted. Define `copy()` with your state model in mind: a value-only copy can lose loading flags, server messages, and error visibility, whereas reusing input instances shares mutable state across form objects.

`FormuxBlocFormValidator` in `flutter_formux` is a widget adapter. It gives its `builder` a zero-argument callback that calls `context.read<B>().validate(onValid)`.

### Complete core example

This example copies the current messages, visibility, loading flag, and `id` explicitly. Those values are mutable in the current API; adapt the copy policy to the state your application needs.

```dart
import 'package:formux/formux.dart';

class UsernameInput extends FormuxStringType {
  UsernameInput({super.value});

  @override
  void validator() => assertion(value.trim().isEmpty, 'Username is required');

  @override
  void clear() {
    value = '';
    hideErrors();
  }
}

class AccountForm extends Formux<AccountForm>
    implements FormuxCopy<AccountForm>, FormuxInputIds {
  AccountForm({String username = ''}) : username = UsernameInput(value: username);

  final UsernameInput username;

  @override
  List<FormuxInput> get inputs => [username];

  @override
  Map<String, FormuxInput> get ids => {'username': username};

  @override
  AccountForm copy() {
    final next = AccountForm(username: username.value)..id = id;
    next.username.messages
      ..clear()
      ..addAll(username.messages);
    next.username.errors = username.errors;
    if (username.isLoading) next.username.loading();
    return next;
  }
}

class AccountCubit extends CubitForm<AccountForm> {
  AccountCubit() : super(AccountForm());
}

Future<void> main() async {
  final cubit = AccountCubit();
  cubit.state.username.value = 'Ada';
  cubit.validate((form) => print(form.username.value));

  final unmatched = [
    InputError(field: 'username', errors: ['Already taken']),
    InputError(field: 'other', errors: ['General error']),
  ];
  cubit.inputErrors(unmatched);
  print(cubit.state.username.error); // Already taken
  print(unmatched.length); // 1: the unknown field remains.
  await cubit.close();
}
```

## Field errors

`InputError(field: ..., errors: ...)` represents server messages for one field. `InputError.fromList()` converts a `List<dynamic>` to strings. A form implementing `FormuxInputIds` exposes `Map<String, FormuxInput> get ids`, mapping server field names to inputs.

`CubitForm.inputErrors(inputErrors)` copies the form, finds the first matching `InputError` for each key in `ids`, adds its **first** message to that input, removes the matched object from the passed list, and emits the copied form. Unknown fields remain in the caller's list. A matched `InputError` with an empty `errors` list throws when `.first` is read. The `flutter_formux` validation-error strategy relies on the remaining list to pass unmatched errors to its general handler.

`InputErrorsException` holds a mutable `errors` list. Its `form(formWithIds)` and `input(input, key)` methods similarly add the first message and remove matched entries. Repeated errors for the same field are not all consumed in one call.

## Error codes

For codes rather than field names, implement `FormuxInputErrorCodes` and expose `Map<String, FormuxInput> get codes`. Call `CubitForm.errorCodes()` with `FormuxInputErrorCode(code: ..., message: ...)` values. Matching codes add their message to the mapped input and are removed from the passed list; unmatched codes remain. The method emits a copied form.

In `flutter_formux`, `FormuxInitializer.binding()` registers strategies for GraphQL validation errors and error codes. `ListenFormuxError` exposes the receiving `CubitForm`; `FlutterFormux.errorsManager` can supply translated messages and handlers for unmatched errors. This integration depends on `pipen_bloc` and `pipen` GraphQL types from the companion package.

Treat lists passed to `inputErrors()`, `errorCodes()`, or `InputErrorsException` helpers as mutable working lists. Make a copy first if the original response must be retained.
