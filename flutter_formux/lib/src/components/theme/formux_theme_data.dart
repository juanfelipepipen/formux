import 'package:flutter_formux/src/models/formux_theme.dart';
import 'package:flutter/cupertino.dart';

class FormuxThemeData extends InheritedWidget {
  const FormuxThemeData({super.key, required this.theme, required super.child});

  final FormuxTheme theme;

  static FormuxThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormuxThemeData>();
  }

  static FormuxThemeData of(BuildContext context) {
    final FormuxThemeData? result = maybeOf(context);
    assert(result != null, 'No FormuxTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FormuxThemeData oldWidget) =>
      theme != oldWidget.theme;
}
