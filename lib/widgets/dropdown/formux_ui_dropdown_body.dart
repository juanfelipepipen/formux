import 'package:pipen/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';

class FormuxUiDropdownBody extends StatelessWidget {
  const FormuxUiDropdownBody(
      {super.key,
      required this.child,
      required this.onAccept,
      required this.acceptLabel,
      required this.cancelLabel,
      required this.buttonsColor});

  final String cancelLabel, acceptLabel;
  final VoidCallback? onAccept;
  final Color buttonsColor;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        height: 260,
        color: context.themeColors.surface,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: CupertinoButton(
                    alignment: Alignment.topLeft,
                    onPressed: Navigator.of(context).pop,
                    child: Text(
                      cancelLabel,
                      style: TextStyle(
                        color: buttonsColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    onPressed: () {
                      onAccept?.call();
                      Navigator.of(context).pop();
                    },
                    alignment: Alignment.topRight,
                    child: Text(
                      acceptLabel,
                      style: TextStyle(
                        color: buttonsColor,
                      ),
                    ),
                  ),
                )
              ]),
              Expanded(child: child)
            ],
          ),
        ),
      );
}
