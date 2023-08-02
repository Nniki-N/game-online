import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:game/presentation/bloc/room_bloc/room_event.dart';

void leaveGameRoom({required BuildContext context, required bool leaveWithLoose}) {
  log('close GameBloc');
  context.read<GameBloc>().close().then((_) {
    log('add LeaveRoomEvent');
    context.read<RoomBloc>().add(LeaveRoomEvent(
          gameRoom: context.read<GameBloc>().state.gameRoom,
          leaveWithLoose: leaveWithLoose,
        ));
  });
}
