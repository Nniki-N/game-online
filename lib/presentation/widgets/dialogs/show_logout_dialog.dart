import 'package:flutter/material.dart';
import 'package:game/presentation/widgets/dialogs/show_generic_dialog.dart';

Future<bool> showLogOutDialog({required BuildContext context}) async {
  return showGenericDialog<bool>(
    context: context,
    dialogTitle: 'Log out',
    dialogContent: 'Are you sure you want to log out?',
    dialogOptionsBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then((logout) => logout ?? false);
}
