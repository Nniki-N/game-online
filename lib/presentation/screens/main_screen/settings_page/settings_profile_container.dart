import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/utils/avatar_selecting.dart';
import 'package:game/domain/entities/account.dart';
import 'package:game/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:game/presentation/bloc/account_bloc/account_state.dart';
import 'package:game/presentation/theme/extensions/settings_item_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class ProfileDetailsContainer extends StatelessWidget {
  final VoidCallback? onTap;

  const ProfileDetailsContainer({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsItemTheme settingsItemTheme =
        Theme.of(context).extension<SettingsItemTheme>()!;

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, accountState) {
        // Settings profile container layout.
        if (accountState is LoadedAccountState) {
          final UserAccount userAccount = accountState.getUserAccount()!;

          return GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: settingsItemTheme.backgroundColor,
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: userAccount.avatarLink != null
                        ? Image.network(
                            userAccount.avatarLink!,
                            width: 61.w,
                            height: 61.w,
                          )
                        : SvgPicture.asset(
                            randomUserAvatar,
                            width: 61.w,
                            height: 61.w,
                          ),
                  ),
                  SizedBox(width: 17.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: userAccount.username,
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 5.h),
                      CustomText(
                        text: '@${userAccount.login}',
                        fontSize: 15.sp,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }

        // Shows tha an account data was not loaded.
        else {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: settingsItemTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: SvgPicture.asset(
                    Svgs.avatarCyan,
                    width: 61.w,
                    height: 61.w,
                  ),
                ),
                SizedBox(width: 17.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.w,
                      height: 20.h,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      width: 100.w,
                      height: 15.h,
                      color: Colors.grey[300],
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}
