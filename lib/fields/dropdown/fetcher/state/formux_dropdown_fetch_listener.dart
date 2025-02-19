import 'package:pipen/abstract/models/pipen_bloc_listener_ignore_exceptions.dart';
import 'package:formux/inputs/formux_valuable_fetch_input.dart';
import 'package:pipen/bloc/listen/bloc_listen_fetch.dart';
import 'package:pipen/valuable/valuable.dart';

class FormuxDropdownFetchListener extends BlocListenFetch<ValuableList>
    implements PipenBlocListenerIgnoreExceptions {
  FormuxDropdownFetchListener({this.onChange});

  final Function(ValuableInputEvent)? onChange;

  @override
  get success => (items) {
        onChange?.call(ValuableSetItems(items: items));
      };
}
