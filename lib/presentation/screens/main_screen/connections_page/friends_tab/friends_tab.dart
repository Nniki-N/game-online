import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/main_screen/connections_page/friends_tab/connections_friend_item.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_icon_text_button.dart';
import 'package:game/resources/resources.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconTextButton(
          text: 'Add friend',
          svgPicture: SvgPicture.asset(
            Svgs.addIcon,
            colorFilter: ColorFilter.mode(
              CustomColors.mainColor,
              BlendMode.srcIn,
            ),
          ),
          spaceBetween: 7.w,
          onTap: () {
            //
          },
        ),
        SizedBox(height: 25.h),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 30.h),
              itemCount: 13,
              itemBuilder: (context, index) {
                return const ConnectionsFriendItem(
                  username: 'Username',
                  totalGames: 30,
                  victories: 25,
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
            ),
          ),
        ),
      ],
    );
  }
}
