library change_notifier_listener;

import 'package:flutter/material.dart';

class ChangeNotifierListener<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierListener({
    Key? key,
    required this.changeNotifier,
    required this.builder,
    this.autoDispose = false,
    this.onDispose,
  })  : assert(!autoDispose || onDispose != null,
            "onDispose can't be null when autoDispose is true"),
        super(key: key);

  final T changeNotifier;
  final Widget Function(BuildContext context, T notifier) builder;
  final bool autoDispose;
  final void Function(T notifier)? onDispose;

  @override
  _ChangeNotifierListenerState<T> createState() =>
      _ChangeNotifierListenerState<T>();
}

class _ChangeNotifierListenerState<T extends ChangeNotifier>
    extends State<ChangeNotifierListener<T>> {
  late T notifier;

  @override
  void initState() {
    notifier = widget.changeNotifier;
    notifier.addListener(() {
      rebuild();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      widget.onDispose!(notifier);
    }
    notifier.removeListener(() {
      rebuild();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, notifier);
  }

  void rebuild() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (mounted) setState(() {});
    });
  }
}
