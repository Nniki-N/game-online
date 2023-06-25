import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/constants/colors_constants.dart';

class CustomSlider extends StatefulWidget {
  final double sliderHeight;
  final double trackHeight;
  final double currentValue;
  final void Function(double value) onCanged;
  final double sliderSideBarsHeight;
  final double sliderSideBarsWidth;

  const CustomSlider({
    super.key,
    required this.sliderHeight,
    required this.trackHeight,
    required this.currentValue,
    required this.onCanged,
    required this.sliderSideBarsHeight,
    required this.sliderSideBarsWidth,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double currentValue;

  @override
  void initState() {
    currentValue = widget.currentValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: widget.sliderHeight,
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: CustomColors.mainDarkColor,
              inactiveTrackColor: CustomColors.mainMudColor,
              thumbColor: CustomColors.mainDarkColor,
              activeTickMarkColor: Colors.transparent,
              trackHeight: widget.trackHeight,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: widget.sliderHeight / 2,
                disabledThumbRadius: widget.sliderHeight / 2,
              ),
              trackShape: CustomTrackShape(),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 15.w),
            ),
            child: Slider(
              value: currentValue,
              min: 0,
              max: 100,
              divisions: 101,
              onChanged: (value) {
                widget.onCanged(value);
                setState(() {
                  currentValue = value;
                });
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: (widget.sliderHeight - widget.sliderSideBarsHeight) / 2,
          child: Container(
            height: widget.sliderSideBarsHeight,
            width: widget.sliderSideBarsWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              color: CustomColors.mainDarkColor,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: (widget.sliderHeight - widget.sliderSideBarsHeight) / 2,
          child: Container(
            height: widget.sliderSideBarsHeight,
            width: widget.sliderSideBarsWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
              color: CustomColors.mainDarkColor,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
