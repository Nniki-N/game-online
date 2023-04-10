import 'package:flutter/material.dart';

typedef DialogOptionsBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String dialogTitle,
  required String dialogContent,
  required DialogOptionsBuilder dialogOptionsBuilder,
}) async {
  final options = dialogOptionsBuilder();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(dialogTitle),
        content: Text(dialogContent),
        actions: options.keys.map(
          (optionTitle) {
            final T? optionValue = options[optionTitle];

            return TextButton(
              onPressed: () {
                if (optionValue != null) {
                  Navigator.of(context).pop(optionValue);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(optionTitle),
            );
          },
        ).toList(),
      );
    },
  );
}
