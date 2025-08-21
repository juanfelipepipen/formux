import 'package:flutter_formux/src/state/dropdown/listener/fetch_field_listener.dart';
import 'package:flutter_formux/src/components/container/formux_field_spacer.dart';
import 'package:flutter_formux/src/state/dropdown/state/fetch_field_cubit.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pipen/valuable.dart';
import 'package:formux/formux.dart';

typedef FetchInputParams<T> =
    ({List<T> items, Function(List<T>) onPick, Function(List<T> items) onItems});

class FormuxFieldPickerBuilder<T> extends StatelessWidget {
  const FormuxFieldPickerBuilder({
    super.key,
    this.state,
    this.label,
    this.value,
    this.items,
    this.fetcher,
    required this.input,
    required this.field,
  });

  final Future<List<T>> Function()? fetcher;
  final FetchInputParams<T> field;
  final String? label, value;
  final ValuableList? items;
  final FormuxInput input;
  final dynamic state;

  @override
  Widget build(BuildContext context) => BlocProvider<FetchFieldCubit<T>>(
    create: (_) => FetchFieldCubit<T>(),
    child: _UcorePickerFetcherLayout<T>(
      input: input,
      state: state,
      label: label,
      items: items,
      value: value,
      params: field,
      fetcher: fetcher,
    ),
  );
}

class _UcorePickerFetcherLayout<T> extends StatefulWidget {
  const _UcorePickerFetcherLayout({
    super.key,
    this.state,
    this.label,
    this.value,
    this.items,
    this.fetcher,
    required this.input,
    required this.params,
  });

  final Future<List<T>> Function()? fetcher;
  final FetchInputParams<T> params;
  final String? label, value;
  final ValuableList? items;
  final FormuxInput input;
  final dynamic state;

  @override
  State<_UcorePickerFetcherLayout<T>> createState() => _UcorePickerFetcherLayoutState<T>();
}

class _UcorePickerFetcherLayoutState<T> extends State<_UcorePickerFetcherLayout<T>> {
  @override
  void initState() {
    super.initState();
    context.read<FetchFieldCubit<T>>().load(widget.fetcher);
  }

  @override
  void didUpdateWidget(covariant _UcorePickerFetcherLayout<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final fetcher = context.read<FetchFieldCubit<T>>().fetcher;
    if (widget.fetcher != fetcher && widget.fetcher != null) {
      widget.params.onItems([]);
    }
    context.read<FetchFieldCubit<T>>().load(widget.fetcher);
  }

  /// Open cupertino picker
  void open() {
    if (widget.params.items.isNotEmpty) {
      widget.params.onPick([...widget.params.items]);
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilderFetch<FetchFieldCubit<T>, List<T>>(
    builder:
        (context, state, bloc) => BlocListenerFetch<FetchFieldCubit<T>, List<T>>(
          listener: FetchFieldListener(onItems: widget.params.onItems),
          child: FormuxFieldSpacer(
            child: FormuxInputField(
              label: widget.label,
              input: widget.input,
              value: widget.value,
              suffixIcon: switch (state) {
                FetchPending() || FetchSuccess() => IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: open,
                ),
                FetchLoading() => FormuxFieldSpinner(),
                FetchFail() => IconButton(icon: Icon(Icons.refresh), onPressed: bloc.refresh),
              },
            ),
          ),
        ),
  );
}
