import 'package:flutter/material.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:game/presentation/widgets/dialogs/show_generic_dialog.dart';

Future<void> showAuthError({
  required BuildContext context,
  required AuthError authError,
}) async {
  await showGenericDialog<void>(
    context: context,
    dialogTitle: authError.errorTitle,
    dialogContent: authError.errorText,
    dialogOptionsBuilder: () => {'Ok': null},
  );
}
