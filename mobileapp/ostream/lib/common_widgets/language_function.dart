import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostream/global_controller/app_settings_cubit/app_settings_cubit.dart';

import '../utils/resources/app_icons.dart';

Future<dynamic> changeLanguage(BuildContext context, bool home) {
  return showAdaptiveActionSheet(
    context: context,
    title: Text(AppLocalizations.of(context)!.choose_your_languages),
    androidBorderRadius: 30,
    actions: <BottomSheetAction>[
      BottomSheetAction(
          title: SvgPicture.asset(AppIcons.ae),
          onPressed: (context) {
            AppSettingsCubit.get(context).changeAppLang('ar');
            Navigator.pop(context);
          }),
      BottomSheetAction(
          title: SvgPicture.asset(AppIcons.en),
          onPressed: (context) {
            AppSettingsCubit.get(context).changeAppLang('en');
            Navigator.pop(context);
          }),
    ],
    isDismissible: true,
    cancelAction: CancelAction(
        title: Text(AppLocalizations.of(context)!
            .cancel)), // onPressed parameter is optional by default will dismiss the ActionSheet
  );
}
