import 'package:flutter/material.dart';

class FormuxFieldSpinner extends StatelessWidget {
  const FormuxFieldSpinner({super.key});

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 20,
    child: CircularProgressIndicator(strokeWidth: 2.5),
  );
}
