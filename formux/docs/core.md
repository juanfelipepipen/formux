# Core inputs and forms

Import the public API with `package:formux/formux.dart`. The package has no Flutter widget dependency. For a complete small example, see the [README](../README.md).

## `FormuxInput<T>`

Extend `FormuxInput<T>` or one of the supplied base types. Implement `validator()` and `clear()`. The constructor accepts `value`, `required` (default `true`), and `displayOnUpdate` (default `false`). Construction runs `validate()` and then hides errors. Assigning `value` runs `validate()` again. A class implementing `FormuxInputValueUpdater<T>` can transform assignments through `onValue()` before validation; the initial constructor value is not passed through that updater.

Inside `validator()`, call `assertion(condition, message)` when `condition` means **invalid**. `validate()` clears previous messages, enables error visibility, and invokes the validator. `addError(message, principal: true)` inserts an external error at the front; without `principal`, it appends it. `passer()` revalidates and throws `FormuxFailedPassException` if the input fails.

| Property | Current meaning |
| --- | --- |
| `value` | Current typed value; assigning it revalidates. |
| `messages` / `error` | All current messages / first message, or `null`. `messages` currently exposes the mutable internal list. |
| `pass` | `true` when there are no messages. This does not account for `required`. |
| `errors` | Whether error display has been enabled. |
| `display` | `true` only when the input fails, `errors` is true, `required` is true, and the input is not loading. |
| `isLoading` | The flag set by `loading()` and cleared by `loaded()`. |

`hideErrors()` and `showErrors()` change visibility; they do not change messages. `assertion()` adds a message but does not itself enable visibility. `required` is mutable. Assigning it, calling `isRequired()`, or calling `requiredFrom()` does not revalidate. The `displayOnUpdate` property is stored by the core input but is not read by its implementation.

An optional input can have validation messages and `pass == false`, but `display == false`. Form-level `passed` ignores inputs whose `required` flag is false. If optional values need validation, implement that policy explicitly in your form or submission flow.

### Supplied base types

| Type | Value type | Added behavior |
| --- | --- | --- |
| `FormuxStringType` | `String` | Defaults to `''`; `valueOrNull`, `update(dynamic)`, and `clear()`. |
| `FormuxIntegerType` | `int?` | Requires an `items` list; empty string for a null `valueToString()`. |
| `FormuxDoubleType` | `double?` | Empty string for a null `valueToString()`. |
| `FormuxDateTimeType` | `DateTime?` | Typed base for date/time inputs. |

The integer, double, and date/time types remain abstract: concrete subclasses must provide validation and clearing behavior. `FormuxStringType` provides `clear()` but still requires a validator.

## `Formux<F>`

A form exposes `List<FormuxInput> get inputs` and implements `F copy()`. It also has an optional mutable `id`. `passed` checks that every **required** input has `pass == true`. `valid()` reads that cached state, calls `showErrors()` if it is false, and returns a boolean. It does **not** revalidate inputs. Call `validate()` when validation rules or other referenced values have changed without a `value` assignment.

| Method/property | Current behavior |
| --- | --- |
| `validate()` | Revalidates each input and returns the form. |
| `passed` | True if all required inputs currently pass. |
| `valid()` | Returns `passed` and shows all input errors on failure. |
| `pass()` | Calls `valid()`; throws `FormuxFailedPassException` if invalid and no callback was supplied. |
| `pass(onPassed: callback)` | Calls the callback on success; returns silently on failure. |
| `loading()` / `loaded()` | Set or clear the loading flag on every input. |
| `isLoading` | True if every input is loading; also true when `inputs` is empty. |
| `showErrors()` / `hideErrors()` | Change visibility on every input. |
| `hasId` | True when `id` is not null. |

`Formux({loading: true})` calls `loading()` during construction. `toMap()` currently constructs a local map and returns `void`; it does not provide serialized values. Use your own explicit mapping for submission.

The exported list extensions add `loading()` and `loaded()` to input lists; the untyped list extension also offers `clearInputs()`, `required()`, and `notRequired()`. The latter two change each input's `required` flag and call `clear()`.
