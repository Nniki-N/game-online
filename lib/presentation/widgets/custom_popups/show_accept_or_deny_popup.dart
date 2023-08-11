import 'package:flutter/material.dart';
import 'package:game/presentation/widgets/custom_popups/show_generic_popup.dart';

/// A custom method that shows just a dialog popup with the choice to cancel
/// or confirm the action.
///
/// [popUpTitle] is a text that is shown as a title of a dialog popup.
///
/// [popUpText] is a text that is shown as a text of a dialog popup.
///
/// [buttonAcceptText] is a text of the button that describes it`s meaning.
/// This button returns true and hides popup.
///
/// [buttonDenyText] is a text of the button that describes it`s meaning.
/// This button returns false and hides popup.
Future<bool> showAcceptOrDenyPopUp({
  required BuildContext context,
  required String popUpTitle,
  required String popUpText,
  required String buttonAcceptText,
  required String buttonDenyText,
}) async {
  return showGenericPopUp(
    context: context,
    popUpTitle: popUpTitle,
    popUpText: popUpText,
    dialogOptionsBuilder: () => {
      buttonDenyText: false,
      buttonAcceptText: true,
    },
  ).then((value) => value ?? false);
}
