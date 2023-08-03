import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/di/locator.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_event.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_state.dart';
import 'package:game/presentation/screens/choose_friend_for_game_screen/friend_list_item.dart';
import 'package:game/presentation/screens/loading_screen.dart/loading_screen.dart';
import 'package:game/presentation/theme/extensions/background_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChoosefriendForGameScreen extends StatelessWidget {
  const ChoosefriendForGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BackgroundTheme backgroundTheme =
        Theme.of(context).extension<BackgroundTheme>()!;
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;

    return BlocProvider(
      create: (context) => FriendsBloc(
        friendsRepository: getIt(),
        accountRepository: getIt(),
      )..add(const InitializeFriendsEvent()),
      child: BlocBuilder<FriendsBloc, FriendsState>(
        builder: (context, friendsState) {
          if (friendsState is InitialFriendsState) {
            return const LoadingScreen();
          }

          return Scaffold(
            backgroundColor: backgroundTheme.color,
            body: Padding(
              padding: EdgeInsets.only(
                top: 45.h,
                left: 30.w,
                right: 30.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomButtonBack(
                        onTap: () {
                          AutoRouter.of(context).replace(const MainRouter());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 55.h),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: AppLocalizations.of(context)!.chooseFriend,
                            fontSize: 26.sp,
                          ),
                          SizedBox(height: 25.h),
                          friendsState.friendsList.isEmpty
                              ? CustomText(
                                  text: AppLocalizations.of(context)!
                                      .youDidNotAddFriendsToYourConnections,
                                  maxLines: 4,
                                  textAlign: TextAlign.center,
                                  color: textTheme.color3,
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: friendsState.friendsList.length,
                                  itemBuilder: (context, index) {
                                    return FriendsListItem(
                                      account: friendsState.friendsList[index],
                                      onTap: () {
                                        //
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 15.h),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
