import 'package:flutter/material.dart';

import '../utils/resources/app_colors.dart';
import '../utils/resources/app_fonts.dart';
import '../utils/resources/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeadLineRow extends StatelessWidget {
  final String title;
  final Function()? fct;
  final String? actionTitle;
  final double? padding;

  const HeadLineRow({super.key, required this.title, this.fct, this.padding, this.actionTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding?? AppConstants.pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppFonts.h1,
          ),
          fct == null
              ? const SizedBox()
              : TextButton(
                  onPressed: fct,
                  child: Text(
                   actionTitle?? AppLocalizations.of(context)!.see_all,
                    style: AppFonts.h1.copyWith(
                      color: AppColors.mainColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.mainColor,
                    ),
                  ))
        ],
      ),
    );
  }
}
