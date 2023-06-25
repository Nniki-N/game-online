import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class LanguageListViewItem extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;

  const LanguageListViewItem({
    super.key,
    required this.index,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: text),
        !isSelected
            ? const SizedBox.shrink()
            : SvgPicture.asset(
                Svgs.arrowDownIcon,
                colorFilter: ColorFilter.mode(
                  CustomColors.mainTextColor,
                  BlendMode.srcIn,
                ),
              ),
      ],
    );
  }
}
