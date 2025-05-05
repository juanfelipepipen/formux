import 'package:pipen_bloc/abstract/bloc_listen_exceptions_ignore.dart';
import 'package:pipen_bloc/listen/bloc_listen_fetch.dart';
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
