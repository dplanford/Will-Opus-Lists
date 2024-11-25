import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

  const AdaptiveAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoAlertDialog(
            key: key,
            title: title,
            content: content,
            actions: actions,
          )
        : AlertDialog(
            key: key,
            title: title,
            content: content,
            actions: actions,
          );
  }
}
