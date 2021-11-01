import 'package:flutter/material.dart';

import '../../extension/context_extension.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  const CustomAlertDialog({Key? key, this.title, this.content, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: context.mediumCircularRadius),
      contentPadding: context.paddingLow,
      title: title,
      content: content,
      actions: actions,
    );
  }
}
