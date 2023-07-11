import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  onTap({required int index, required TabsRouter tabsRouter}) {
    tabsRouter.setActiveIndex(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 85.h,
        ),
        Positioned(
          left: -10.w,
          right: -10.w,
          top: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
              color: CustomColors.mainColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.w),
                topRight: Radius.circular(35.w),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomBottomNavigationBarItem(
                    index: 0,
                    itemText: AppLocalizations.of(context)!.connections,
                    svgPicturePath: Svgs.connectionIcon,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: CustomBottomNavigationBarItem(
                    index: 1,
                    itemText: AppLocalizations.of(context)!.game,
                    svgPicturePath: Svgs.gameIcon,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: CustomBottomNavigationBarItem(
                    index: 2,
                    itemText: AppLocalizations.of(context)!.settings,
                    svgPicturePath: Svgs.gearIcon,
                    onTap: onTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomBottomNavigationBarItem extends StatelessWidget {
  final int index;
  final String svgPicturePath;
  final String itemText;
  final void Function({
    required int index,
    required TabsRouter tabsRouter,
  }) onTap;

  const CustomBottomNavigationBarItem({
    super.key,
    required this.svgPicturePath,
    required this.itemText,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TabsRouter tabsRouter = AutoTabsRouter.of(context);
    final int activeIndex = tabsRouter.activeIndex;

    final Color color =
        index == activeIndex ? Colors.white : CustomColors.menuLightGreenColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GestureDetector(
        onTap: () {
          onTap(index: index, tabsRouter: tabsRouter);
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPicturePath,
              width: 37.w,
              height: 37.w,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 5.h),
            CustomText(
              text: itemText,
              fontSize: 14.sp,
              color: color,
            )
          ],
        ),
      ),
    );
  }
}
