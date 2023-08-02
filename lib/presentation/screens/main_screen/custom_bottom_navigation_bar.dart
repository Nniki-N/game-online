import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/bottom_bar_theme.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';

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
    final BottomBarTheme bottomBarTheme =
        Theme.of(context).extension<BottomBarTheme>()!;

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
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            decoration: BoxDecoration(
              color: bottomBarTheme.backgroundColor,
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
                    // svgPicturePath: Svgs.connection,
                    iconData: Ionicons.git_network_outline,
                    iconDataSelected: Ionicons.git_network,
                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: CustomBottomNavigationBarItem(
                    index: 1,
                    itemText: AppLocalizations.of(context)!.game,
                    // svgPicturePath: Svgs.game,
                    iconData: Ionicons.game_controller_outline,
                    iconDataSelected: Ionicons.game_controller,

                    onTap: onTap,
                  ),
                ),
                Expanded(
                  child: CustomBottomNavigationBarItem(
                    index: 2,
                    itemText: AppLocalizations.of(context)!.settings,
                    // svgPicturePath: Svgs.gear,
                    iconData: Ionicons.settings_outline,
                    iconDataSelected: Ionicons.settings,

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
  // final String svgPicturePath;
  final IoniconsData iconData;
  final IoniconsData iconDataSelected;
  final String itemText;
  final void Function({
    required int index,
    required TabsRouter tabsRouter,
  }) onTap;

  const CustomBottomNavigationBarItem({
    super.key,
    // required this.svgPicturePath,
    required this.iconData,
    required this.iconDataSelected,
    required this.itemText,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TabsRouter tabsRouter = AutoTabsRouter.of(context);
    final int activeIndex = tabsRouter.activeIndex;

    final BottomBarTheme bottomBarTheme =
        Theme.of(context).extension<BottomBarTheme>()!;

    final Color color = index == activeIndex
        ? bottomBarTheme.activeColor
        : bottomBarTheme.inactiveColor;

    final IoniconsData usedIconData =
        index == activeIndex ? iconDataSelected : iconData;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: GestureDetector(
        onTap: () {
          onTap(index: index, tabsRouter: tabsRouter);
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              usedIconData,
              size: 37.w,
              color: color,
            ),
            SizedBox(height: 5.h),
            CustomText(
              text: itemText,
              fontSize: 12.sp,
              color: color,
            )
          ],
        ),
      ),
    );
  }
}
