library change_notifier_listener;

import 'package:flutter/material.dart';

class ChangeNotifierListener extends StatefulWidget {
  ChangeNotifierListener({
    Key? key,
    required this.changeNotifier,
    required this.builder,
  }) : super(key: key);

  final ChangeNotifier changeNotifier;
  final Widget Function(BuildContext context) builder;

  @override
  _ChangeNotifierListenerState createState() => _ChangeNotifierListenerState();
}

class _ChangeNotifierListenerState extends State<ChangeNotifierListener> {
  @override
  void initState() {
    widget.changeNotifier.addListener(() {
      rebuild();
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.changeNotifier.removeListener(() {
      rebuild();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    if (mounted) setState(() {});
  }
}
