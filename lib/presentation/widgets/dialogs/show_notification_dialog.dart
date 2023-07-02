import 'package:flutter/material.dart';
import 'package:game/presentation/widgets/dialogs/show_generic_dialog.dart';

/// A custom method that shows just a notification dialog popup.
///
/// [dialogTitle] is a text that is shown as a title of a dialog popup.
///
/// [dialogContent] is a text that is shown as a text of a dialog popup.
/// 
/// [buttonText] is a text of the button that describes it`s meaning.
/// The button returns nothing, just hides popup.
Future<void> showNotificationDialog({
  required BuildContext context,
  required String dialogTitle,
  required String dialogContent,
  required String buttonText,
}) async {
  showGenericDialog(
    context: context,
    dialogTitle: dialogTitle,
    dialogContent: dialogContent,
    dialogOptionsBuilder: () => {buttonText: null},
  );
}