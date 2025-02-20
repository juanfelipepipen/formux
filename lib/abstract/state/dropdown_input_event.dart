sealed class DropdownInputEvent<T> {}

class DropdownSetValue<T> extends DropdownInputEvent<T> {
  DropdownSetValue({required this.value});

  T value;
}

class DropdownSetItems<T> extends DropdownInputEvent<T> {
  DropdownSetItems({required this.items});

  List<T> items;
}

class DropdownSetFetch<T> extends DropdownInputEvent<T> {
  DropdownSetFetch({required this.fetch});

  Future<List<T>> Function() fetch;
}

class DropdownSetFetchClear<T> extends DropdownInputEvent<T> {
  DropdownSetFetchClear({required this.fetch});

  Future<List<T>> Function() fetch;
}
