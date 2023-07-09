import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/screens/choose_friend_for_game_screen/friend_list_item.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button_back.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';

class ChoosefriendForGameScreen extends StatelessWidget {
  const ChoosefriendForGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      text: 'Choose friend',
                      fontSize: 26.sp,
                    ),
                    SizedBox(height: 25.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return FriendsListItem(
                          username: 'Username',
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
  }
}
