import 'package:pipen/valuable.dart';
import 'package:pipen_bloc/pipen_bloc.dart';

class DropdownFetcherCubit extends CubitFetchResolverPending<ValuableList> {
  DropdownFetcherCubit({this.initial}) : super();

  /// Initial value
  Valuable? initial;

  /// Initial fetcher
  ValuableListFetchCallback? fetcher;

  /// Load valuable list from fetcher
  void load(ValuableListFetchCallback? fetcher) {
    if (fetcher != null && fetcher != this.fetcher) {
      this.fetcher = fetcher;
      fetch(_fetcher(fetcher));
    }
  }

  /// Clear items list
  void empty() {
    success([]);
  }

  void refresh() {
    if (fetcher != null) {
      fetch(_fetcher(fetcher!));
    }
  }

  /// Fetcher for state
  Future<ValuableList> _fetcher(ValuableListFetchCallback fetch) async {
    final list = await fetch();
    return list;
  }
}
