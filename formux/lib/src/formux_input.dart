part of 'formux.dart';

abstract class FormuxInput<T> {
  /// Current input error
  String? get error => _messages.isNotEmpty ? _messages.first : null;

  /// Display error
  bool get display => !pass && errors && required && !isLoading;

  /// Input value is required
  bool required;

  /// Show input error
  bool errors = false;

  /// Input is loading data
  bool _loading = false;

  /// Display changes in every input value change
  bool displayOnUpdate;

  /// Error messages
  List<String> get messages => _messages;

  /// List of input errors
  List<String> _messages = [];

  /// Input value
  T _value;

  /// [Getter] Input passed or failed
  bool get pass => _messages.isEmpty;

  /// [Getter] Get is input is loading
  bool get isLoading => _loading;

  /// [Getter] Input value
  T get value => _value;

  /// [Constructor]
  FormuxInput({
    required T value,
    this.required = true,
    this.displayOnUpdate = false,
  }) : _value = value {
    validate();
    hideErrors();
  }

  /// [Abstract] Input validator
  void validator();

  /// [Abstract] Clear input
  void clear();

  /// [Setter] Set input value and handle validations
  set value(T value) {
    if (this case FormuxInputValueUpdater<T> valueUpdater) {
      _value = valueUpdater.onValue(value);
    } else {
      _value = value;
    }

    validate();
  }

  /// Validate input
  void validate() {
    _messages = [];
    errors = true;
    validator();
  }

  /// Throw if input isn't pass
  void passer() {
    validate();
    if (!pass) throw FormuxFailedPassException();
  }

  /// Add custom error
  void addError(String message, {bool? principal}) {
    if (principal == true) {
      _messages = [message, ..._messages];
    } else {
      _messages.add(message);
    }

    errors = true;
  }

  /// Assertion for invalidate input
  void assertion(bool condition, String message) {
    if (condition) {
      _messages.add(message);
    }
  }

  /// Is loading flag
  void loading() {
    _loading = true;
  }

  /// Is loaded flag
  void loaded() {
    _loading = false;
  }

  /// Make input required
  void isRequired() {
    required = true;
  }

  /// Show input errors
  void showErrors() {
    errors = true;
  }

  /// Hide input errors
  void hideErrors() {
    errors = false;
  }

  /// Make input required from bool
  void requiredFrom(bool? value) {
    required = value == true;
  }

  /// Convert current value to string
  String valueToString() {
    return value.toString();
  }
}
