import 'package:flutter/cupertino.dart';
import 'package:flutter_formux/flutter_formux.dart';
import 'package:formux/formux.dart';
import 'package:pipen/components.dart';
import 'package:pipen/extensions.dart';

class FormuxErrorContainer extends StatelessWidget {
  const FormuxErrorContainer({
    super.key,
    required this.child,
    required this.input,
  });

  final FormuxInput input;
  final Widget child;

  @override
  Widget build(BuildContext context) => PipenColumn(
    spacing: PipenGap.verySmallSize,
    children: [
      child,
      FormuxErrorText(
        padding: EdgeInsets.symmetric(
          horizontal:
              context.theme.inputDecorationTheme.contentPadding?.horizontal ??
              0,
        ),
        input: input,
      ),
    ],
  );
}
