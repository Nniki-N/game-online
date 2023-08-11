import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/domain/entities/language.dart';
import 'package:game/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:game/presentation/bloc/language_bloc/language_event.dart';
import 'package:game/presentation/theme/extensions/text_theme.dart';
import 'package:game/presentation/widgets/custom_texts/custom_text.dart';
import 'package:game/resources/resources.dart';

class LanguageListViewItem extends StatelessWidget {
  final int index;

  const LanguageListViewItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final Language language = Language.values[index];
    final Language appLanguage = context.read<LanguageBloc>().state.language;
    final String text = language.languageName;
    final bool isSelected = index == appLanguage.index;

    final TextTheme textTheme = Theme.of(context).extension<TextTheme>()!;

    return GestureDetector(
      onTap: () {
        context.read<LanguageBloc>().add(ChangeLanguageEvent(
              language: Language.values[index],
            ));
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: text),
            !isSelected
                ? const SizedBox.shrink()
                : SvgPicture.asset(
                    Svgs.arrowDown,
                    colorFilter: ColorFilter.mode(
                      textTheme.color,
                      BlendMode.srcIn,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
