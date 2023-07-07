import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/domain/entities/chip.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';
import 'package:game/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:game/presentation/bloc/game_bloc/game_event.dart';
import 'package:game/presentation/bloc/game_bloc/game_state.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_state.dart';
import 'package:game/presentation/screens/game_screens/field.dart';
import 'package:game/presentation/screens/game_screens/leave_game_room.dart';
import 'package:game/presentation/screens/game_screens/online_footer.dart';
import 'package:game/presentation/screens/game_screens/online_header.dart';
import 'package:game/presentation/screens/game_screens/row_with_buttons.dart';
import 'package:game/presentation/widgets/dialogs/show_accept_or_deny_dialog.dart';

class OnlineGameScreen extends StatelessWidget {
  const OnlineGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StreamController<Chips?> chipStreamController =
        StreamController<Chips?>();

    final Stream<Chips?> chipStream =
        chipStreamController.stream.asBroadcastStream();

    final AccountBloc accountBloc = context.watch<AccountBloc>();

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
          log('listener: ro0mState --- ${roomState.toString()}');

          // Navigates user back to the main screen if the user is outside the room.
          if (roomState is OutsideRoomState) {
            log('online game room ------------------ go to the main room');
            AutoRouter.of(context).replace(const MainRouter());
          }

          // Notifies that the game room is not full and offers to wait for a second player or leave the room.
          else if (roomState is InRoomState) {
            log('online game room ------------------ missing player dialog');
            final isPopUpShown = ModalRoute.of(context)?.isCurrent != true;

            if (!isPopUpShown) {
              showAcceptOrDenyDialog(
                context: context,
                dialogTitle: 'Player left',
                dialogContent: 'Do you want to wait for a new player?',
                buttonAcceptText: 'Wait',
                buttonDenyText: 'Leave',
              ).then((wait) {
                if (wait) {
                  log('online game room ------------------ go to the waiting room');
                  AutoRouter.of(context).replace(const WaitingRoomRouter());
                } else {
                  log('one in room ------------------- leave room');

                  leaveGameRoom(
                    context: context,
                    leaveWithLoose: false,
                  );
                }
              });
            }
          }

          // Navigates user back to the main screen if an error occurs.
          else if (roomState is ErrorRoomState) {
            log('roomError in the online game room screen');
            AutoRouter.of(context).replace(const MainRouter());
          }
        },
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, gameState) {
            // Sets the chip size as null if it is a turn of a second player.
            final bool turnOfSecondPlayer =
                accountBloc.state.getUserAccount()!.uid !=
                    gameState.gameRoom.turnOfPlayerUid;

            if (turnOfSecondPlayer) {
              chipStreamController.add(null);
            }

            // Notifies that the game ended and offers to restart the game.
            if (gameState is ResultGameState) {
              log('online game room ------------------ show result of the game');

              final isPopUpShown = ModalRoute.of(context)?.isCurrent != true;

              if (!isPopUpShown) {
                final String winnerUid = gameState.gameRoom.winnerUid;
                final String winnerName = gameState.gameRoom.players
                    .firstWhere((winner) => winner.uid == winnerUid)
                    .username;

                showAcceptOrDenyDialog(
                  context: context,
                  dialogTitle: 'Game finished',
                  dialogContent:
                      'Pleyer $winnerName won. Do you want to restart the game with the same player?',
                  buttonAcceptText: 'Restart',
                  buttonDenyText: 'Leave',
                ).then((restartGame) {
                  if (restartGame) {
                    context.read<GameBloc>().add(const RestartGameEvent());
                  } else {
                    log('game finished ------------------- leave room');

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
              log('errorText ${gameState.errorText}');
              log('errorTitle ${gameState.errorTitle}');

              // showNotificationDialog(
              //   context: context,
              //   dialogTitle: 'Some error happened',
              //   dialogContent:
              //       'Something happened during the game, therefore game is finished, but it won`t be considered as a loose.',
              //   buttonText: 'Ok',
              // ).then((_) => AutoRouter.of(context).replace(const MainRouter()));
            }
          },
          builder: (context, gameState) {
            // Layout of a sceen.
            return Scaffold(
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
