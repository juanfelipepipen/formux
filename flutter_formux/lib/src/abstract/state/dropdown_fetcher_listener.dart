import 'package:flutter_formux/flutter_formux.dart';
import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:pipen/valuable.dart';

class DropdownFetcherListener extends BlocListenFetch<ValuableList>
    implements BlocListenExceptionsIgnore {
  DropdownFetcherListener({this.onChange});

  final Function(ValuableInputEvent event)? onChange;

  @override
  get success => (items) {
    onChange?.call(ValuableInputEvent.setItems(items));
  };
}
