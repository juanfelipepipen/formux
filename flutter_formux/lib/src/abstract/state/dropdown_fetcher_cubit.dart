import 'package:pipen_bloc/pipen_bloc.dart';

typedef Fetcher<T> = Future<List<T>> Function();

class DropdownFetcherCubit<T> extends CubitFetchResolverPending<List<T>> {
  DropdownFetcherCubit({this.initial}) : super();

  /// Initial value
  T? initial;

  /// Initial fetcher
  Fetcher<T>? fetcher;

  /// Load valuable list from fetcher
  void load(Fetcher<T>? fetcher) {
    if (fetcher != null && fetcher != this.fetcher) {
      this.fetcher = fetcher;
      fetch(_fetcher(fetcher));
    }
  }

  /// Clear items list
  void empty() {
    emit(FetchSuccess<List<T>>([]));
  }

  void refresh() {
    if (fetcher != null) {
      fetch(_fetcher(fetcher!));
    }
  }

  /// Fetcher for state
  Future<List<T>> _fetcher(Fetcher<T> fetch) async {
    List<T> list = await fetch();
    return list;
  }
}
