import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game/presentation/theme/extensions/slider_them.dart'
    as custom_slider;

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
    final custom_slider.SliderTheme sliderTheme =
        Theme.of(context).extension<custom_slider.SliderTheme>()!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: widget.sliderHeight,
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: sliderTheme.activeTrackColor,
              inactiveTrackColor: sliderTheme.inactiveTrackColor,
              thumbColor: sliderTheme.thumbColor,
              activeTickMarkColor: sliderTheme.activeTickMarkColor,
              inactiveTickMarkColor: sliderTheme.inactiveTickMarkColor,
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
              color: sliderTheme.sideBarColor,
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
              color: sliderTheme.sideBarColor,
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
