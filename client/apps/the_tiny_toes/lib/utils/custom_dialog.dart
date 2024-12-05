import 'package:flutter/cupertino.dart';

class CustomDialog {
  static void cupertinoAlert({
    required BuildContext context,
    required String title,
    String? subtitle,
    String buttonText = 'Ok',
    String? cancelButton,
    VoidCallback? onCancel,
    VoidCallback? onProceed,
  }) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          content: subtitle != null
              ? Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14),
                )
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: onProceed ??
                  () {
                    Navigator.of(context).pop();
                  },
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (cancelButton != null)
              CupertinoDialogAction(
                onPressed: onCancel,
                child: Text(
                  cancelButton,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        );
      },
    );
  }
}