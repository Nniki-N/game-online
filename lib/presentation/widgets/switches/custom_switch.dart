import 'package:flutter/material.dart' hide SwitchTheme;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/switch_theme.dart';

class CustomSwitch extends StatefulWidget {
  final bool isSelected;
  final void Function(bool) onChanged;

  const CustomSwitch({
    super.key,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double switchBodyHight = 16.h;
    final double switchBodyWidth = 36.w;
    final double trackSize = 20.w;

    final SwitchTheme switchTheme = Theme.of(context).extension<SwitchTheme>()!;

    return GestureDetector(
      onTap: () {
        widget.onChanged(isSelected);
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: switchBodyWidth,
            height: switchBodyHight,
            decoration: BoxDecoration(
              color: isSelected
                  ? switchTheme.activeBackgroundColor
                  : switchTheme.inactiveBackgroundColor,
              borderRadius: BorderRadius.circular(10.w),
            ),
          ),
          Positioned(
            top: -(trackSize - switchBodyHight) / 2,
            left: !isSelected ? 0 : null,
            right: isSelected ? 0 : null,
            child: Container(
              width: trackSize,
              height: trackSize,
              decoration: BoxDecoration(
                color: isSelected
                    ? switchTheme.activeForegroundColor
                    : switchTheme.inactiveForegroundColor,
                borderRadius: BorderRadius.circular(10.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
