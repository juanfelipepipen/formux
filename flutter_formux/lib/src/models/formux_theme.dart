class FormuxTheme {
  FormuxTheme({this.widthMode = WidthMode.max, this.spacer = 0});

  final WidthMode widthMode;
  final double spacer;

  FormuxTheme copyWith({WidthMode? widthMode, double? spacer}) =>
      FormuxTheme(spacer: spacer ?? this.spacer, widthMode: widthMode ?? this.widthMode);
}

enum WidthMode { max, min, layout }
