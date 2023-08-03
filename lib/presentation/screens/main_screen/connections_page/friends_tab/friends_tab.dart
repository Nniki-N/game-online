import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide IconTheme, TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_bloc.dart';
import 'package:game/presentation/bloc/friends_bloc/friends_state.dart';
import 'package:game/presentation/screens/main_screen/connections_page/friends_tab/connections_friend_item.dart';
import 'package:game/presentation/theme/extensions/icon_theme.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_icon_text_button.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final IconTheme iconTheme = Theme.of(context).extension<IconTheme>()!;
    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconTextButton(
          text: AppLocalizations.of(context)!.addFriend,
          svgPicture: SvgPicture.asset(
            Svgs.add,
            colorFilter: ColorFilter.mode(
              iconTheme.color2,
              BlendMode.srcIn,
            ),
            width: 18.w,
            height: 18.h,
          ),
          spaceBetween: 7.w,
          onTap: () {
            AutoRouter.of(context).push(const AddFriendRouter());
          },
        ),
        Expanded(
          child: BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, friendsState) {
              return friendsState.friendsList.isEmpty
                  ? Center(
                      child: CustomText(
                        text: AppLocalizations.of(context)!.youDidNotAddFriendsToYourConnections,
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        color: textTheme.color3,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: SingleChildScrollView(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 30.h),
                          itemCount: friendsState.friendsList.length,
                          itemBuilder: (context, index) {
                            return ConnectionsFriendItem(
                              account: friendsState.friendsList[index],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 15.h),
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
