import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

class MultiBlocProviderP extends StatelessWidget {
  const MultiBlocProviderP({
    super.key,
    required this.builder,
    required this.providers,
  });

  final Function(BuildContext context) builder;
  final List<SingleChildWidget> providers;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: providers,
    child: _MultiBlocProviderP(builder: builder),
  );
}

class _MultiBlocProviderP extends StatelessWidget {
  const _MultiBlocProviderP({required this.builder});

  final Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) => builder(context);
}
