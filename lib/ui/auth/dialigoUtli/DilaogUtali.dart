import 'package:flutter/material.dart';

class DialogUtils {
  void showLoading(BuildContext context, String message,
      {bool isCancelable = true}) {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                width: 12,
              ),
              Text(message),
            ],
          ),
        );
      },
      barrierDismissible: isCancelable,
    );
  }

  void showMessage(BuildContext context,
      {required String message,
        String? posActionTitle,
        String? negActionTitle,
        VoidCallback? posAction,
        VoidCallback? negAction,
        bool isCancelable = true}) {
    List<Widget> actions = [];
    if (posActionTitle != null) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          posAction?.call();
        },
        child: Text(posActionTitle),
      ));
    }
    if (negActionTitle != null) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          negAction?.call();
        },
        child: Text(negActionTitle),
      ));
    }

    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          actions: actions,
          content: Row(
            children: [Expanded(child: Text(message))],
          ),
        );
      },
    );
  }

  void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void showMessageError(BuildContext context, String message,
      {bool isCancelable = true,
        String? posActionTitle}) {
    showDialog(
      context: context,
      builder: (BuildContext) {
        List<Widget> actions = [];
        if (posActionTitle != null) {
          actions.add(TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(posActionTitle),
          ));
        }

        return AlertDialog(
          actions: actions,
          content: Row(
            children: [
              Expanded(child: Text(message)),
            ],
          ),
        );
      },
      barrierDismissible: isCancelable,
    );
  }
}
