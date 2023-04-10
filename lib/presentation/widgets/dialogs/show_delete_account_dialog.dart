import 'package:flutter/material.dart';
import 'package:game/presentation/widgets/dialogs/show_generic_dialog.dart';

Future<bool> showDeleteAccountDialog({required BuildContext context}) async {
  return showGenericDialog<bool>(
    context: context,
    dialogTitle: 'Lelete account',
    dialogContent: 'Are you sure you want to delete your account? You cannot undo this operation!',
    dialogOptionsBuilder: () => {
      'Cancel': false,
      'Delete account': true,
    },
  ).then((delete) => delete ?? false);
}
