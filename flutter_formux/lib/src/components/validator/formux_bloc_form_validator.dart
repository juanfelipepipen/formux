import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:formux/formux.dart';

class FormuxBlocFormValidator<B extends CubitForm<F>, F extends Formux> extends StatelessWidget {
  const FormuxBlocFormValidator({super.key, required this.builder, required this.onValid});

  final Widget Function(BuildContext context, Function() validator) builder;
  final Function(F) onValid;

  @override
  Widget build(BuildContext context) => builder(context, () => context.read<B>().validate(onValid));
}
