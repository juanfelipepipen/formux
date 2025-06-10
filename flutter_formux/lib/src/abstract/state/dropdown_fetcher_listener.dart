import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:formux/formux.dart';

class DropdownFetcherListener<T> extends BlocListenFetch<List<T>>
    implements BlocListenExceptionsIgnore {
  DropdownFetcherListener({this.onChange});

  final Function(DropdownInputEvent<T>)? onChange;

  @override
  get success => (items) {
    onChange?.call(DropdownSetItems<T>(items: items));
  };
}
