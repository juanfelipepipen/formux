import 'package:flutter_formux/flutter_formux.dart';
import 'package:flutter/widgets.dart';

class FormuxFieldSpacer extends StatelessWidget {
  const FormuxFieldSpacer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: FormuxThemeData.maybeOf(context)?.theme.spacer ?? 0),
    child: child,
  );
}
