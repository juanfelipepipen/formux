import 'package:pipen/cubit/cubit_fetch.dart';
import 'package:pipen/valuable/valuable.dart';

class DropdownCubit extends CubitFetchResolver<ValuableList> {
  List<Valuable> get items {
    if (state case FetchSuccess<ValuableList> success) return success.result;
    return [];
  }

  ValuableListFetchCallback? fetcher;

  /// Load valuable list from fetcher
  void load(ValuableListFetchCallback? fetcher) {
    if (fetcher != null && fetcher != this.fetcher) {
      this.fetcher = fetcher;
      fetch(fetcher());
    }

    if (fetcher == null && this.fetcher != null) {
      empty();
    }
  }

  /// Handle current fetcher
  void refresh() {
    if (fetcher case ValuableListFetchCallback fetcher) {
      fetch(fetcher());
    }
  }

  /// Clear items list
  void empty() {
    emit(FetchSuccess<ValuableList>(const []));
  }
}
