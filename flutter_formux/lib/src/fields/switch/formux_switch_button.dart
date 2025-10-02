import 'package:flutter/cupertino.dart';
import 'package:pipen/extensions.dart';

class FormuxSwitchButton extends StatelessWidget {
  const FormuxSwitchButton({
    super.key,
    this.onChange,
    this.activeColor,
    this.value = false,
    this.enabled = true,
  });

  final Function(bool value)? onChange;
  final bool value, enabled;
  final Color? activeColor;

  Color get color => activeColor ?? CupertinoColors.activeBlue;

  @override
  Widget build(BuildContext context) => CupertinoSwitch(
    value: value,
    activeTrackColor: enabled
        ? color
        : context.themeColors.primary.withValues(alpha: 0.7),
    onChanged: (bool value) {
      if (enabled) {
        onChange?.call(value);
      }
    },
  );
}
