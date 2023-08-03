import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/connections_tab_bar_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectionsTabBar extends StatefulWidget {
  const ConnectionsTabBar({
    super.key,
  });

  @override
  State<ConnectionsTabBar> createState() => _ConnectionsTabBarState();
}

class _ConnectionsTabBarState extends State<ConnectionsTabBar> {
  onTap({required int index, required TabsRouter tabsRouter}) {
    tabsRouter.setActiveIndex(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ConnectionsTabBarTheme connectionsTabBarTheme = Theme.of(context).extension<ConnectionsTabBarTheme>()!;
    
    return Container(
      height: 55.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: connectionsTabBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: ConnectionsTabBarItem(
              index: 0,
              text: AppLocalizations.of(context)!.friendsAndMe,
              onTap: onTap,
            ),
          ),
          Container(
            height: 25.h,
            width: 1.w,
            decoration: BoxDecoration(
              color: connectionsTabBarTheme.separatorColor,
              borderRadius: BorderRadius.circular(1.w),
            ),
          ),
          Expanded(
            child: ConnectionsTabBarItem(
              index: 1,
              text: AppLocalizations.of(context)!.notifications,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class ConnectionsTabBarItem extends StatelessWidget {
  final int index;
  final String text;
  final void Function({
    required int index,
    required TabsRouter tabsRouter,
  }) onTap;

  const ConnectionsTabBarItem({
    super.key,
    required this.index,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TabsRouter tabsRouter = AutoTabsRouter.of(context);
    final int activeIndex = tabsRouter.activeIndex;

    final ConnectionsTabBarTheme connectionsTabBarTheme = Theme.of(context).extension<ConnectionsTabBarTheme>()!;

    final Color color = index == activeIndex
        ? connectionsTabBarTheme.selectedTabTextColor
        : connectionsTabBarTheme.tabTextColor;

    final FontWeight fontWeight =
        index == activeIndex ? FontWeight.w500 : FontWeight.w400;

    return GestureDetector(
      onTap: () {
        onTap(
          index: index,
          tabsRouter: tabsRouter,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: CustomText(
          text: text,
          textAlign: TextAlign.center,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
