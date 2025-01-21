import 'package:formux/fields/dropdown/form_fetch/state/dropdown_fetch_cubit.dart';
import 'package:pipen/cubit/cubit_fetch.dart';
import 'package:pipen/valuable/valuable.dart';
import 'package:flutter/cupertino.dart';

class DropdownFetchListener {
  DropdownFetchListener({required this.listen, this.onChange}) {
    _listen();
  }

  final Function(Valuable?)? onChange;
  final (BuildContext, FetchState) listen;

  BuildContext get context => listen.$1;
  FetchState get state => listen.$2;

  /// Listen state
  void _listen() {
    if (state case FetchSuccess<DropdownState> success) {
      onChange?.call(success.result.$1);
    }

    if (state is FetchLoading) {
      onChange?.call(null);
    }
  }
}
