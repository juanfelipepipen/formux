import 'package:flutter/cupertino.dart';
import 'package:flutter_formux/flutter_formux.dart';

class WidthModeBuilder extends StatelessWidget {
  const WidthModeBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, double? width) builder;

  @override
  Widget build(BuildContext context) {
    final mode = FormuxThemeData.maybeOf(context)?.theme.widthMode;
    return mode == WidthMode.layout
        ? LayoutBuilder(builder: (context, constrains) => builder(context, constrains.maxWidth))
        : builder(context, switch (mode ?? WidthMode.max) {
          WidthMode.max => double.infinity,
          _ => null,
        });
  }
}
