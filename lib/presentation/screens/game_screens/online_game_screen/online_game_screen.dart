import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/common/errors/game_room_error.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';
import 'package:game/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:game/presentation/bloc/game_bloc/game_event.dart';
import 'package:game/presentation/bloc/game_bloc/game_state.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';
import 'package:game/presentation/screens/game_screens/online_game_screen/field.dart';
import 'package:game/presentation/screens/game_screens/online_game_screen/leave_game_room.dart';
import 'package:game/presentation/screens/game_screens/online_game_screen/online_footer.dart';
import 'package:game/presentation/screens/game_screens/online_game_screen/online_header.dart';
import 'package:game/presentation/screens/game_screens/online_game_screen/row_with_buttons.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/widgets/popups/show_accept_or_deny_popup.dart';
import 'package:game/presentation/widgets/popups/show_notification_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnlineGameScreen extends StatelessWidget {
  const OnlineGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StreamController<Chips?> chipStreamController =
        StreamController<Chips?>();

    final Stream<Chips?> chipStream =
        chipStreamController.stream.asBroadcastStream();

    final AccountBloc accountBloc = context.read<AccountBloc>();

    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;

    return BlocProvider(
      create: (context) => GameBloc(
        gameRepository: getIt(),
        roomRepository: getIt(),
        accountRepository: getIt(),
        gameRoom: (context.read<RoomBloc>().state as InFullRoomState).gameRoom,
      )
        ..add(const InitializeGameEvent())
        ..add(const StartGameEvent()),
      child: BlocListener<RoomBloc, RoomState>(
        listener: (context, roomState) {
          // Navigates user back to the main screen if the user is outside the room.
          if (roomState is OutsideRoomState) {
            log('online game room ------------------ go to the main room');
            AutoRouter.of(context).replace(const MainRouter());
          }

          // Notifies that the game room is not full and offers to wait for a second player
          // or leave the room.
          else if (roomState is InRoomState) {
            log('online game room ------------------ missing player dialog');
            final isPopUpShown = ModalRoute.of(context)?.isCurrent != true;

            // Shows a popup if another popup is not opened.
            if (!isPopUpShown) {
              showAcceptOrDenyPopUp(
                context: context,
                dialogTitle: AppLocalizations.of(context)!.secondPlayerLeft,
                dialogContent:
                    AppLocalizations.of(context)!.doYouWantToWaitForNewPlayer,
                buttonAcceptText: AppLocalizations.of(context)!.wait,
                buttonDenyText: AppLocalizations.of(context)!.leave,
              ).then((wait) {
                if (wait) {
                  log('online game room ------------------ go to the waiting room');
                  AutoRouter.of(context).replace(const WaitingRoomRouter());
                } else {
                  leaveGameRoom(
                    context: context,
                    leaveWithLoose: false,
                  );
                }
              });
            }
          }

          // Navigates user back to the main screen if an error of specified type occurs.
          else if (roomState is ErrorRoomState) {
            // Checks if it is an error when user has to be navigated back to the main screen.
            final GameRoomError gameRoomError = roomState.gameRoomError;
            final bool notWrongMoveError =
                gameRoomError is! GameRoomErrorInvalidPlayerMove;

            // Navigates user back to the main screen.
            if (notWrongMoveError) {
              log('roomError in the online game room screen');
              leaveGameRoom(
                context: context,
                leaveWithLoose: false,
              );
            }
          }
        },
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, gameState) {
            // Sets the chip size as null if it is a turn of a second player.
            final bool turnOfSecondPlayer =
                accountBloc.state.getUserAccount()!.uid !=
                    gameState.gameRoom.turnOfPlayerUid;

            if (turnOfSecondPlayer) chipStreamController.add(null);

            // Notifies that the game ended and offers to restart the game.
            if (gameState is ResultGameState) {
              log('online game room ------------------ show result of the game');

              final isPopUpShown = ModalRoute.of(context)?.isCurrent != true;

              // Shows a popup if another popup is not opened.
              if (!isPopUpShown) {
                final String winnerUid = gameState.gameRoom.winnerUid;
                final String currentUid =
                    context.read<AccountBloc>().state.getUserAccount()!.uid;
                final String winnerUsername = currentUid == winnerUid
                    ? AppLocalizations.of(context)!.you
                    : gameState.gameRoom.players
                        .firstWhere((winner) => winner.uid == winnerUid)
                        .username;

                showAcceptOrDenyPopUp(
                  context: context,
                  dialogTitle: AppLocalizations.of(context)!.gameFinished,
                  dialogContent:
                      '$winnerUsername won. Do you want to restart the game with the same player?',
                  buttonAcceptText: AppLocalizations.of(context)!.restart,
                  buttonDenyText: AppLocalizations.of(context)!.leave,
                ).then((restartGame) {
                  if (restartGame) {
                    context.read<GameBloc>().add(const RestartGameEvent());
                  } else {
                    leaveGameRoom(
                      context: context,
                      leaveWithLoose: false,
                    );
                  }
                });
              }
            }

            // Shows an error massage and navigates user back to the main screen if an error occurs.
            else if (gameState is ErrorGameState) {
              log('gameError in the online game room screen');

              // Checks if it is an error when user has to be navigated back to the main screen.
              final GameRoomError gameRoomError = gameState.gameRoomError;
              final bool wrongMoveError =
                  gameRoomError is GameRoomErrorInvalidPlayerMove;

              // Shows a popup if another popup is not opened.
              if (wrongMoveError) {
                showNotificationDialog(
                  context: context,
                  dialogTitle: gameRoomError.errorTitle,
                  dialogContent: gameRoomError.errorText,
                  buttonText: AppLocalizations.of(context)!.ok,
                );
              }

              // Navigates user back to the main screen.
              else {
                log('roomError in the online game room screen');

                showNotificationDialog(
                  context: context,
                  dialogTitle: AppLocalizations.of(context)!.gameError,
                  dialogContent: AppLocalizations.of(context)!
                      .someKindOfGameErrorHasOccured,
                  buttonText: AppLocalizations.of(context)!.ok,
                ).then((_) {
                  leaveGameRoom(
                    context: context,
                    leaveWithLoose: false,
                  );
                });
              }
            }
          },
          builder: (context, gameState) {
            // Layout of the game sceen.
            return Scaffold(
              backgroundColor: backgroundTheme.color,
              body: Column(
                children: [
                  const OnlineHeader(),
                  StreamBuilder(
                    stream: chipStream,
                    builder: (context, snapshot) {
                      return Field(
                        chipSize: snapshot.data,
                        // Sets the chip size to make a move as null in case it was not changed.
                        setChipSizeAsZero: () {
                          chipStreamController.add(null);
                          log('chipSize: null was added to the stream');
                        },
                      );
                    },
                  ),
                  const RowWithButtons(),
                  SizedBox(height: 20.h),
                  OnlineFooter(
                    // Selects the chip size to make a move if it is the turn of the current user.
                    onTap: ({required Chips chipSize}) {
                      final bool chipSelectingIsAllowed =
                          accountBloc.state.getUserAccount()!.uid ==
                              gameState.gameRoom.turnOfPlayerUid;

                      if (chipSelectingIsAllowed) {
                        chipStreamController.add(chipSize);
                        log('chipSize: $chipSize was added to the stream');
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
