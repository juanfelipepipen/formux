import 'package:pipen_bloc/pipen_bloc.dart';

class FetchFieldCubit<T> extends CubitFetchResolverPending<List<T>> {
  FetchFieldCubit({this.initial}) : super();

  /// Initial value
  T? initial;

  /// Initial fetcher
  Future<List<T>> Function()? fetcher;

  /// Load valuable list from fetcher
  void load(Future<List<T>> Function()? fetcher) {
    if (fetcher != null && fetcher != this.fetcher) {
      this.fetcher = fetcher;
      fetch(_fetcher(fetcher));
    }
  }

  /// Clear items list
  void empty() {
    success([]);
  }

  /// Retry fetch data
  void refresh() {
    if (fetcher != null) {
      fetch(_fetcher(fetcher!));
    }
  }

  /// Fetcher for state
  Future<List<T>> _fetcher(Future<List<T>> Function() fetch) async {
    final list = await fetch();
    return list;
  }
}
