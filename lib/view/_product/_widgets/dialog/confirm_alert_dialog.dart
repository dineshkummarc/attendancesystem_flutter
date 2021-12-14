import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/dialog/custom_alert_dialog.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final VoidCallback? onPressed;

  const ConfirmAlertDialog({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: buildTitle(context),
      content: buildContentPadding(context),
      actions: [buildActionsPadding(context)],
    );
  }

  Text buildTitle(BuildContext context) {
    return Text.rich(TextSpan(children: [
      WidgetSpan(child: Icon(Icons.check_box, color: context.colorSchemeLight.green)),
      TextSpan(
          text: LocaleKeys.changepassword_alert_title.tr(),
          style: Theme.of(context).textTheme.bodyText1!)
    ]));
  }

  Padding buildContentPadding(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Text(LocaleKeys.changepassword_alert_desc.tr(),
          style: Theme.of(context).textTheme.bodyText2!),
    );
  }

  Padding buildActionsPadding(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
              onPressed: onPressed,
              child: Text(LocaleKeys.changepassword_alert_button.tr(),
                  textAlign: TextAlign.center, style: context.textTheme.bodyText2!)),
        ],
      ),
    );
  }
}
