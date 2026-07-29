import 'package:formux/formux.dart';

abstract class FormuxFetcherInput<T> extends FormuxInput<T?> {
  FormuxFetcherInput({required super.value, super.required});

  /// Fetcher function
  Future<List<T>> Function()? get fetcher;
}
