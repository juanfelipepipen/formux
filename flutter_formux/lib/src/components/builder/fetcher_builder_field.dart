import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_formux/src/state/dropdown/listener/fetch_field_listener.dart';
import 'package:flutter_formux/src/state/dropdown/state/fetch_field_cubit.dart';
import 'package:pipen/components.dart';
import 'package:pipen_bloc/pipen_bloc.dart';

class FetcherBuilderField<T> extends StatelessWidget {
  const FetcherBuilderField({super.key, required this.builder, required this.onItems});

  final Function(List<T>) onItems;
  final Widget Function(BuildContext context, FetchState<List<T>> state, FetchFieldCubit<T> bloc)
  builder;

  @override
  Widget build(BuildContext context) => BlocProvider<FetchFieldCubit<T>>(
    lazy: false,
    create: (_) => FetchFieldCubit<T>(),
    child: BlocBuilderFetch<FetchFieldCubit<T>, List<T>>(
      builder:
          (context, state, bloc) => BlocListenerFetch<FetchFieldCubit<T>, List<T>>(
            listener: FetchFieldListener(onItems: onItems),
            child: PipenGap.verySmall(child: builder(context, state, bloc)),
          ),
    ),
  );
}
