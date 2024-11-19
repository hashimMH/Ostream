import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../utils/resources/app_colors.dart';
import '../utils/resources/app_fonts.dart';

class ReadMoreWidget extends StatelessWidget {
  final String text;
  final int? lines;
  const ReadMoreWidget({super.key, required this.text, this.lines,});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Line,
      style: AppFonts.body1,
      trimLines: lines??2,
      colorClickableText: AppColors.mainColor,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
    );
  }
}
