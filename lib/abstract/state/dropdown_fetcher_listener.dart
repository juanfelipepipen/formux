import 'package:pipen/abstract/models/pipen_bloc_listener_ignore_exceptions.dart';
import 'package:formux/abstract/state/dropdown_input_event.dart';
import 'package:pipen/bloc/listen/bloc_listen_fetch.dart';

class DropdownFetcherListener<T> extends BlocListenFetch<List<T>>
    implements PipenBlocListenerIgnoreExceptions {
  DropdownFetcherListener({this.onChange});

  final Function(DropdownInputEvent<T>)? onChange;

  @override
  get success => (items) {
        onChange?.call(DropdownSetItems<T>(items: items));
      };
}
