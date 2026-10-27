# Flutter inputs and components

The Flutter UI and concrete inputs are in the sibling `flutter_formux` package. Add both packages to a Flutter app and import `package:formux/formux.dart` for core types plus `package:flutter_formux/flutter_formux.dart` for the exported Flutter API. This catalog is based on that package's current public export file and source, rather than on a tested published build.

## Localization setup

Many concrete input validators read `formuxLocalization` through `FormuxTranslations`. Input construction immediately runs validation, so assign `formuxLocalization` **before constructing** those inputs. `FormuxLocalization.of(context)` must be called from a context below `MaterialApp`'s localization delegates.

```dart
MaterialApp(
  localizationsDelegates: FormuxLocalization.localizationsDelegates,
  supportedLocales: FormuxLocalization.supportedLocales,
  home: const MyFormPage(),
)
```

In the form page's `State.didChangeDependencies()`, for example:

```dart
FormuxStringInput? nameInput;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  formuxLocalization = FormuxLocalization.of(context);
  nameInput ??= FormuxStringInput();
}
```

The checked-in delegate currently supports Spanish (`es`). For other locales, inspect and provide suitable localization before relying on these translated validators. `formuxLocalization` is a package-level global, so its value is shared by all forms in the isolate.

## Concrete inputs

| Input | Value / notable parameters | Current role |
| --- | --- | --- |
| `FormuxStringInput` | `String`; `length`, `maxLength`, `validations` | Text validation; `onlyAlphanumeric` is the available validation option. |
| `FormuxStringValueInput` | `String?`; `items`, `length`, `maxLength` | Nullable selected string value. |
| `FormuxStringFetchInput` | `String?`; `fetcher`, `validations` | String input with an optional list fetcher. |
| `FormuxEmailInput` | `String` | Required/format validation with `email_validator`; subclasses can use `FormuxEmailAllowedDomains`. |
| `FormuxBooleanInput` | `bool` | Requires a true value by default; has `notRequired()`. |
| `FormuxBooleanNullInput` | `bool?` | Requires a non-null value by default. |
| `FormuxDoubleInput` | `double?` | Required check and numeric display conversion. |
| `FormuxIntegerInput` | `int?`; `items`, `fetcher`, min/max | Supports `IntegerInputEvent` updates and clamps assigned values through `FormuxInputValueUpdater`. |
| `FormuxDateInput` | `DateTime?`; min/max dates, `minNow` | Date input with required and lower-bound validation. |
| `FormuxValuableInput` | `Valuable?`; `items`, `fetch` | Selected `pipen` `Valuable` option. |
| `FormuxValuableFetchInput` | `Valuable?`; `items`, `fetch` | Fetchable option input with `ValuableInputEvent` updates. |
| `FormuxFileInput` | `PlatformFile?` | File selection value. |
| `FormuxLatLngInput` | `LatLng?` | Coordinate selection value. |

Most nullable or string inputs expose a `notRequired` constructor. The `required` flag belongs to the core input and controls form-level acceptance and error display; validators can still record messages on optional inputs. Read an input's exact constructor and `validator()` before assuming all parameters are enforced as validation rules.

## Field widgets

| Widget | Input / use |
| --- | --- |
| `FormuxTextField` | General text field; requires `input` and `onChange(String)`. Also has `.obscureText` and `.textArea` constructors and a `password()` helper. |
| `FormuxPasswordField` | `FormuxStringType`; wraps `FormuxTextField` with an optional visibility button. |
| `FormuxDoubleField` | `FormuxDoubleInput`; calls `onChange(double)` and can show a loading skeleton from a `FetchState`. |
| `FormuxDropdownFieldBuilder<T>` | Generic `DropdownMenu<T>` with an input, a `DropdownBuilderParams<T>` record, and optional fetcher. |
| `FormuxDropdownFetcherField` | Convenience dropdown for `FormuxValuableFetchInput`; `onChange` receives `ValuableInputEvent`. |
| `FormuxSwitchButton` | Cupertino switch with a `bool` value and callback; it does not take a `FormuxInput`. |

For a text field, pass the same input owned by your form and assign the value in `onChange`:

```dart
FormuxTextField(
  input: form.name,
  label: 'Name',
  onChange: (text) {
    form.name.value = text;
    // Rebuild or emit the form state according to your app's state model.
  },
)
```

`FormuxTextField` uses a controller container to sync displayed text from `input.valueToString()` and uses `input.display`/`input.error` for decoration. A value change on its own does not notify Flutter to rebuild a widget; wire updates through your app's state management.

### Choosing a field

- Use `FormuxTextField` with a string input for ordinary text, `.textArea` for multiple lines, and `FormuxPasswordField` when the visibility button is useful.
- Use `FormuxDoubleField` with `FormuxDoubleInput` for decimal values. Its `state` parameter is for a `pipen_bloc` loading state; the field reads the parsed controller value and passes it to `onChange`.
- Use `FormuxDropdownFieldBuilder<T>` when the options are generic objects. Its `field` record supplies `items`, display text (`lister`), initial selection, `onChange`, and `onItems`. Supply `fetcher` for asynchronous options.
- Use `FormuxDropdownFetcherField` with `FormuxValuableFetchInput` when options are `Valuable` values. Its `onChange` receives an event; send that event to the input or to your state layer.
- `FormuxSwitchButton` takes a raw `bool`. Connect its callback to your own input or form state if the switch is part of validation.

## Supporting components

| Component | Purpose |
| --- | --- |
| `FormuxInputContainer`, `FormuxInputField` | Decorated input shell and value/label display; `.info` displays informational text. |
| `FormuxErrorText`, `FormuxErrorContainer` | Error text and a child plus error layout, driven by `input.display`. |
| `FormuxControllerContainer`, `FormuxCurrencyControllerContainer` | Text controller wrappers for core and currency fields. |
| `FormuxFieldSpacer`, `FormuxFieldSpinner`, `FormuxInputText` | Spacing, loading indicator, and input text helpers. |
| `FetcherFieldBuilder<T>` | Fetch state, retry, and item callback around asynchronously loaded field options. |
| `FormuxBlocFormValidator<B, F>` | Supplies a validation callback to its builder and forwards valid forms to `onValid`. |
| `FormuxThemeData`, `FormuxTheme`, `WidthMode` | Optional inherited layout configuration for spacing and dropdown width. |
| `FormuxInitializer`, `FlutterFormux.errorsManager` | Integration hooks for `pipen_bloc` error strategies and general error handling. |

`FormuxInputText` displays a label and optional value in a `FormuxInputContainer`. `MultiBlocProviderP` wraps multiple BLoC providers and calls a builder under them. `FormuxYearGenerator.fromTo(from, to)` and `.from(from)` produce descending years, excluding `to` or the current year; `.fromNowTo(maxYears: n)` produces ascending years starting at the current year, with `n` entries. `FormuxTool.loading()` is currently a no-op despite being exported.

`FormuxValuableType` is the base for `Valuable` inputs. It stores `items` and an optional `fetch` callback, and provides item lookup and update helpers. `FormuxFetcherInput<T>` is the base contract for inputs with a `Future<List<T>> Function()? fetcher`. `FormuxErrorCodesManager` supplies `errorsTranslations`, `onErrorCode`, and `onInputErrors`; `ListenFormuxError` exposes the `CubitForm` that receives mapped errors. Call `FormuxInitializer.binding()` when setting up this strategy integration; it adds strategies to the global `BlocListen.strategies` list each time it is called.

`FormuxThemeData(theme: FormuxTheme(...), child: ...)` optionally configures vertical field spacing and dropdown width mode for its descendants. Without it, `FormuxFieldSpacer` uses zero extra vertical spacing. `FormuxErrorText` shows the input's current first message only while `input.display` is true and its own `errors` option is true.

`FormuxDateRangeValidator` is an exported mixin for forms with `dateFrom` and `dateTo`; call `dateRangeValidator()` explicitly. It adjusts required flags based on whether both dates are present and can append a range error. It is not invoked automatically by `Formux.validate()`.

Several supporting types are exported for customization, but their APIs remain closely tied to the companion package's current widget and `pipen` dependencies. Prefer the higher-level field widgets unless you need to build a new field type.

`FormuxFieldPickerBuilder` and `FormuxDoubleControllerContainer` exist in `flutter_formux/lib/src` but are not exported from `package:flutter_formux/flutter_formux.dart` in the checked-in version, so they are not listed as public components here.
