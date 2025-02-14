import 'package:pipen/cubit/cubit_fetch.dart';
import 'package:pipen/valuable/valuable.dart';

typedef DropdownState = (Valuable? value, ValuableList items);

class DropdownFetchCubit extends CubitFetchResolver<DropdownState> {
  DropdownFetchCubit({this.initial}) : super();

  /// Initial value
  Valuable? initial;

  /// Initial fetcher
  ValuableListFetchCallback? fetcher;

  /// Get items for dropdown list
  List<Valuable> get items {
    if (state case FetchSuccess<DropdownState> success) {
      return success.result.$2;
    }
    return [];
  }

  /// Current value on dropdown
  Valuable? get value {
    if (state case FetchSuccess<DropdownState> success) {
      return success.result.$1;
    }
    return null;
  }

  /// Load valuable list from fetcher
  void load(ValuableListFetchCallback? fetcher) {
    if (fetcher != null && fetcher != this.fetcher) {
      this.fetcher = fetcher;
      fetch(_fetcher(fetcher()));
    }
  }

  /// Clear items list
  void empty() {
    emit(FetchSuccess<DropdownState>((null, [])));
  }

  /// Fetcher for state
  Future<DropdownState> _fetcher(ValuableListFetch fetch) async {
    ValuableList list = await fetch;
    Valuable? value;

    if (initial != null) {
      final index = list.indexWhere((e) => e.value == initial?.value);
      value = index > -1 ? list[index] : null;
    }

    return (value, list);
  }
}
