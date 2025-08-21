import 'package:flutter/cupertino.dart';

class OnInit extends StatefulWidget {
  const OnInit({super.key, required this.callback, required this.child});

  final VoidCallback callback;
  final Widget child;

  @override
  State<OnInit> createState() => _OnInitState();
}

class _OnInitState extends State<OnInit> {
  @override
  void initState() {
    widget.callback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
