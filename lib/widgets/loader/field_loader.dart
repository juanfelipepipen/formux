import 'package:flutter/material.dart';

class FieldLoader extends StatelessWidget {
  const FieldLoader({super.key});

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator(strokeWidth: 2.5),
      );
}
