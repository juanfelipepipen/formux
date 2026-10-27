# Core API and documentation proposal

Status: proposed. This document records review findings; it does not change the current API or behavior.

## Context

`formux` provides the form and input abstractions, validation state, server-error mapping, and `CubitForm`. Flutter widgets and concrete inputs live in the separate `flutter_formux` package. Existing applications depend on the current behavior, so changes should start by recording that behavior and checking compatibility with consumers.

At the time of this review, `dart analyze` completed without issues. The repository's only test file, `test/formux_test.dart`, has an empty `main()`. Static analysis therefore does not establish the runtime behavior described below.

## Findings and proposals

### 1. Server-error mapping has implicit, mutable behavior

`CubitForm.inputErrors()` and `InputErrorsException.form()` / `.input()` take only the first message for a matching field and remove the matched `InputError` from the caller's list. `CubitForm.errorCodes()` also removes matched entries from its input list. Accessing `.first` throws if a matching error has an empty `errors` list. Repeated entries for the same field are not all applied.

This list mutation is observable: `flutter_formux` passes the remaining errors to a general error handler after calling `CubitForm.inputErrors()`. Preserve that integration while deciding whether consuming entries should remain the contract or whether a new API should return both mapped and unmatched errors.

Proposed work:

- Document whether input lists are consumed, how duplicate fields are handled, and whether only the first message is shown.
- Add characterization tests for matched, unmatched, duplicate, and empty-message entries, including the `flutter_formux` handoff.
- Decide on a single mapping policy for `CubitForm` and `InputErrorsException`. Treat a change to list mutation or message selection as a compatibility-sensitive change.

Relevant code: `lib/src/cubit/cubit_form.dart`, `lib/src/exceptions/input_errors_exception.dart`, and `lib/src/models/input_error.dart`.

### 2. Validation state can be changed without recalculation

`FormuxInput.value` runs `validate()`, but `required`, `isRequired()`, and `requiredFrom()` do not. `Formux.valid()` checks the current `pass` values; it does not call `Formux.validate()`. This matters for forms that change whether a field is required after it was last validated. `flutter_formux` includes code that assigns `required` directly.

Proposed work:

- Document when validators run and when callers must revalidate after changing validation rules.
- Characterize the current behavior of `passed`, `valid()`, `validate()`, `pass()`, `showErrors()`, and `hideErrors()`.
- Consider an explicit API for changing `required` and revalidating. Avoid silently changing the behavior of the public mutable field without checking consumers.

Relevant code: `lib/src/formux.dart` and `lib/src/formux_input.dart`.

### 3. Error messages expose internal mutable state

`FormuxInput.messages` returns the internal mutable list. A caller can add or remove messages without calling `validate()`, `addError()`, or `assertion()`. Also, `assertion()` appends a message but does not set the `errors` visibility flag, unlike `addError()`.

Proposed work:

- Define whether `messages` is an observation API or an editing API, and document the intended error-visibility behavior of `assertion()`.
- Consider a read-only view and explicit mutation methods if direct list editing is not part of the intended contract. Check downstream uses before changing the getter.

Relevant code: `lib/src/formux_input.dart`.

### 4. Form and Cubit lifecycle needs an explicit contract

`CubitForm.validate()` invokes `onValid` before emitting a copy of the form. A callback can therefore act while the Cubit's current state is still the pre-emission state. `CubitForm` also requires `FormuxCopy<F>` at runtime, while `Formux<F>` already declares `copy()`. The error path throws a generic exception if that extra interface is absent.

Proposed work:

- Document the callback and emission order, and specify what `copy()` must preserve: input values, validation messages, error visibility, loading state, and form metadata.
- Add a characterization test for callback order and for a representative copy implementation.
- Consider consolidating the copy contract in a later compatibility review. Do not remove `FormuxCopy` without checking existing implementations.

Relevant code: `lib/src/cubit/cubit_form.dart`, `lib/src/formux.dart`, and `lib/src/abstract/formux_copy.dart`.

### 5. Small API edge cases and unfinished behavior

- `Formux.isLoading` uses `every()`, so an empty `inputs` list reports `true`. Define the intended empty-form result before changing it.
- `Formux.toMap()` creates a local map but returns `void` and does not expose the map. Decide whether it should be removed, replaced, or return a value; changing its signature needs a compatibility check.
- `Formux.pass(onPassed: ...)` throws for an invalid form only when no callback is supplied. With a callback, an invalid form returns without calling it. Document this behavior or design a clearer success/failure API.
- Review whether `displayOnUpdate` has a supported role in this core package; it is stored but not read by the core implementation.

Relevant code: `lib/src/formux.dart` and `lib/src/formux_input.dart`.

## Documentation work

The public README currently lists features and installation but has no working example. Add a minimal Dart example showing a concrete `FormuxInput`, a `Formux` implementation, validation, and error visibility. Document `CubitForm` and server-error mapping separately, then link to the Flutter components package for widget integration. Keep examples aligned with the published API and explain the behavior that may surprise callers: cached validation, optional inputs, copy semantics, and consumed error lists.

## Suggested sequence

1. Document the current contracts and add behavior-focused tests for the cases above.
2. Improve server-error handling while retaining the `flutter_formux` unmatched-error flow.
3. Decide whether validation-state and message encapsulation changes can be additive.
4. Address `toMap()`, empty-form loading, and copy-contract cleanup with explicit compatibility and versioning decisions.

Before a release, validate both packages together and check representative consuming applications. The review and static analysis alone are not a runtime or integration verification.
