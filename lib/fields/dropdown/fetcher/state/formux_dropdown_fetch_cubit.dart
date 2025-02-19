import 'package:pipen/cubit/cubit_fetch.dart';
import 'package:pipen/valuable/valuable.dart';

class FormuxDropdownFetchCubit extends CubitFetchResolverPending<ValuableList> {
  FormuxDropdownFetchCubit({this.initial}) : super();

  /// Initial value
  Valuable? initial;

  /// Initial fetcher
  ValuableListFetchCallback? fetcher;

  /// Get items for dropdown list
  List<Valuable> get items {
    if (state case FetchSuccess<ValuableList> success) {
      return success.result;
    }
    return [];
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
    emit(FetchSuccess<ValuableList>([]));
  }

  void refresh() {
    if (fetcher != null) {
      fetch(_fetcher(fetcher!()));
    }
  }

  /// Fetcher for state
  Future<ValuableList> _fetcher(ValuableListFetch fetch) async {
    ValuableList list = await fetch;
    return list;
  }
}
