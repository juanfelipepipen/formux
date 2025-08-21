import 'package:pipen_bloc/pipen_bloc.dart';

class FetchFieldListener<T> extends BlocListenFetch<List<T>> {
  FetchFieldListener({required this.onItems});

  final Function(List<T> items) onItems;

  @override
  get success => (items) {
        onItems(items);
      };
}
