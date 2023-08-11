import 'package:flutter/material.dart';
import 'package:game/common/errors/account_error.dart';
import 'package:game/common/errors/auth_error.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:game/common/errors/friends_error.dart';
import 'package:game/common/errors/game_room_error.dart';
import 'package:game/common/errors/profile_avatar_error.dart';

CustomLocalizedError getLocalizatedError(
  BuildContext context, {
  required dynamic error,
}) {
  // switch (error) {
  //   case AuthErrorInvalidEmail:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.invalidEmail,
  //       errorText: AppLocalizations.of(context)!.pleaseDoubleCheckYourEmailAndTryAgain,
  //     );
  //   case AuthErrorInvalidPassword:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.invalidPassword,
  //       errorText: AppLocalizations.of(context)!.pleaseTryAgain,
  //     );
  //   case AuthErrorWrongPassword:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.wrongPassword,
  //       errorText: AppLocalizations.of(context)!.thePasswordIsInvalidForTheGivenEmail,
  //     );
  //   case AuthErrorCredentialAlreadyInUse:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.invalidCredential,
  //       errorText: AppLocalizations.of(context)!.theCredentialIsAlreadyInUse,
  //     );
  //   case AuthErrorUserNotFound:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.userNotFound,
  //       errorText: AppLocalizations.of(context)!.theUserWithGivenCredentialsWasNotFound,
  //     );
  //   case AuthErrorOperationNotAllowed:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.operationNotAllowed,
  //       errorText: AppLocalizations.of(context)!.youCannotRegisterUsingThisMethodAtThisMoment,
  //     );
  //   case AuthErrorLoginIsAlreadyUsed:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.loginIsAlreadyUsed,
  //       errorText: AppLocalizations.of(context)!.thisLoginIsAlreadyUsedPleaseTryAnotherOne,
  //     );
  //   case AuthErrorEmailAlreadyInUse:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.emailAlreadyInUse,
  //       errorText: AppLocalizations.of(context)!.pleaseChooseAnotherEmailToRegisterWith,
  //     );
  //   case AuthErrorWeakPassword:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.weakPassword,
  //       errorText: AppLocalizations.of(context)!.pleaseChooseAStrongerPasswordConsistingOfMoreCharacters,
  //     );
  //   case AuthErrorAccountExistsWithDifferentCredential:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.invalidEmail,
  //       errorText: AppLocalizations.of(context)!.anAccountWithThisEmailAddressAlreadyExists,
  //     );
  //   case FriendsErrorThisUserIsAlreadyFriend:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.unableToAddAFriend,
  //       errorText: AppLocalizations.of(context)!.thisUserIsAlreadyYourFriend,
  //     );
  //   case FriendsErrorNotExistingUserWithLogin:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.canNotFindUser,
  //       errorText: AppLocalizations.of(context)!.userWithSuchLoginDoesNotExist,
  //     );
  //   case FriendsErrorCanNotAddYourselfAsFriend:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.itIsYou,
  //       errorText: AppLocalizations.of(context)!.youCanNotAddYourselfToYourConnections,
  //     );
  //   case GameRoomErrorInvalidPlayerMove:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.wrongMove,
  //       errorText: AppLocalizations.of(context)!.thisMoveCanNotBeMade,
  //     );
  //   case ProfileAvatarErrorSelectingPhoto:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.unableToSelectAPhoto,
  //       errorText: AppLocalizations.of(context)!.somethingHappenedWhileSelectingPhoto,
  //     );
  //   case AccountErrorLoginIsUsed:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.unableToChangeALogin,
  //       errorText: AppLocalizations.of(context)!.thisLoginIsAlreadyUsed,
  //     );

  //   default:
  //     return CustomLocalizedError(
  //       errorTitle: AppLocalizations.of(context)!.error,
  //       errorText: AppLocalizations.of(context)!.somethingWentWrong,
  //     );
  // }

  if (error is AuthErrorInvalidEmail) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.invalidEmail,
      errorText:
          AppLocalizations.of(context)!.pleaseDoubleCheckYourEmailAndTryAgain,
    );
  } else if (error is AuthErrorInvalidPassword) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.invalidPassword,
      errorText: AppLocalizations.of(context)!.pleaseTryAgain,
    );
  } else if (error is AuthErrorWrongPassword) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.wrongPassword,
      errorText:
          AppLocalizations.of(context)!.thePasswordIsInvalidForTheGivenEmail,
    );
  } else if (error is AuthErrorCredentialAlreadyInUse) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.invalidCredential,
      errorText: AppLocalizations.of(context)!.theCredentialIsAlreadyInUse,
    );
  } else if (error is AuthErrorUserNotFound) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.userNotFound,
      errorText:
          AppLocalizations.of(context)!.theUserWithGivenCredentialsWasNotFound,
    );
  } else if (error is AuthErrorOperationNotAllowed) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.operationNotAllowed,
      errorText: AppLocalizations.of(context)!
          .youCannotRegisterUsingThisMethodAtThisMoment,
    );
  } else if (error is AuthErrorLoginIsAlreadyUsed) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.loginIsAlreadyUsed,
      errorText: AppLocalizations.of(context)!
          .thisLoginIsAlreadyUsedPleaseTryAnotherOne,
    );
  } else if (error is AuthErrorEmailAlreadyInUse) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.emailAlreadyInUse,
      errorText:
          AppLocalizations.of(context)!.pleaseChooseAnotherEmailToRegisterWith,
    );
  } else if (error is AuthErrorWeakPassword) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.weakPassword,
      errorText: AppLocalizations.of(context)!
          .pleaseChooseAStrongerPasswordConsistingOfMoreCharacters,
    );
  } else if (error is AuthErrorAccountExistsWithDifferentCredential) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.invalidEmail,
      errorText: AppLocalizations.of(context)!
          .anAccountWithThisEmailAddressAlreadyExists,
    );
  } else if (error is FriendsErrorThisUserIsAlreadyFriend) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.unableToAddAFriend,
      errorText: AppLocalizations.of(context)!.thisUserIsAlreadyYourFriend,
    );
  } else if (error is FriendsErrorNotExistingUserWithLogin) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.canNotFindUser,
      errorText: AppLocalizations.of(context)!.userWithSuchLoginDoesNotExist,
    );
  } else if (error is FriendsErrorCanNotAddYourselfAsFriend) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.itIsYou,
      errorText:
          AppLocalizations.of(context)!.youCanNotAddYourselfToYourConnections,
    );
  } else if (error is GameRoomErrorInvalidPlayerMove) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.wrongMove,
      errorText: AppLocalizations.of(context)!.thisMoveCanNotBeMade,
    );
  } else if (error is ProfileAvatarErrorSelectingPhoto) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.unableToSelectAPhoto,
      errorText:
          AppLocalizations.of(context)!.somethingHappenedWhileSelectingPhoto,
    );
  } else if (error is AccountErrorLoginIsUsed) {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.unableToChangeALogin,
      errorText: AppLocalizations.of(context)!.thisLoginIsAlreadyUsed,
    );
  } else {
    return CustomLocalizedError(
      errorTitle: AppLocalizations.of(context)!.error,
      errorText: AppLocalizations.of(context)!.somethingWentWrong,
    );
  }
}

class CustomLocalizedError {
  final String errorTitle;
  final String errorText;

  CustomLocalizedError({
    required this.errorTitle,
    required this.errorText,
  });
}
