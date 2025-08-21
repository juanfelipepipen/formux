import 'package:flutter_formux/src/state/dropdown/listener/fetch_field_listener.dart';
import 'package:flutter_formux/src/state/dropdown/state/fetch_field_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipen_bloc/pipen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pipen/components.dart';

class FetcherFieldBuilder<T> extends StatelessWidget {
  const FetcherFieldBuilder({
    super.key,
    this.fetcher,
    required this.builder,
    required this.onItems,
  });

  final Widget Function(BuildContext context, FetchState<List<T>> state, FetchFieldCubit<T> bloc)
  builder;
  final Future<List<T>> Function()? fetcher;
  final Function(List<T>) onItems;

  @override
  Widget build(BuildContext context) => BlocProvider<FetchFieldCubit<T>>(
    lazy: false,
    create: (_) => FetchFieldCubit<T>(),
    child: BlocBuilderFetch<FetchFieldCubit<T>, List<T>>(
      builder:
          (context, state, bloc) => BlocListenerFetch<FetchFieldCubit<T>, List<T>>(
            listener: FetchFieldListener(onItems: onItems),
            child: PipenGap.verySmall(
              child: _BuilderLayout<T>(
                fetcher: fetcher,
                onItems: onItems,
                child: builder(context, state, bloc),
              ),
            ),
          ),
    ),
  );
}

class _BuilderLayout<T> extends StatefulWidget {
  const _BuilderLayout({super.key, this.fetcher, required this.child, required this.onItems});

  final Future<List<T>> Function()? fetcher;
  final Function(List<T>) onItems;
  final Widget child;

  @override
  State<_BuilderLayout<T>> createState() => _BuilderLayoutState<T>();
}

class _BuilderLayoutState<T> extends State<_BuilderLayout<T>> {
  @override
  void initState() {
    super.initState();
    context.read<FetchFieldCubit<T>>().load(widget.fetcher);
  }

  @override
  void didUpdateWidget(covariant _BuilderLayout<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final fetcher = context.read<FetchFieldCubit<T>>().fetcher;
    if (widget.fetcher != fetcher && widget.fetcher != null) {
      widget.onItems([]);
    }
    context.read<FetchFieldCubit<T>>().load(widget.fetcher);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
