import 'package:formux/fields/dropdown/form_fetch/state/dropdown_fetch_cubit.dart';
import 'package:pipen/bloc/listen/bloc_listen_fetch.dart';
import 'package:pipen/valuable/valuable.dart';

class DropdownFetchListener extends BlocListenFetch<DropdownState> {
  DropdownFetchListener({this.onChange});

  final Function(Valuable?)? onChange;

  @override
  get success => (result) {
        onChange?.call(result.$1);
      };

  @override
  get loading {
    return onChange?.call(null);
  }
}
