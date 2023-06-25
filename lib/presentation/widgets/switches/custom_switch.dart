import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';

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
    final double switchBodyHight = 10.h;
    final double switchBodyWidth = 24.w;
    final double trackSize = 14.w;

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
              color: Colors.grey.shade400,
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
                color:
                    isSelected ? CustomColors.mainColor : Colors.grey.shade600,
                borderRadius: BorderRadius.circular(10.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
