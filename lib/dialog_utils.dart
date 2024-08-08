import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String massage}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(massage),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMassage(
      {required BuildContext context,
      required String content,
      String title = '',
      String? posActionName,
      Function? posAction,
      String? negActionName,
      Function? nesAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName)));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            nesAction?.call();
          },
          child: Text(negActionName)));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              content,
            ),
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Color(0xff101010)),
            ),
            actions: actions,
          );
        });
  }
}
