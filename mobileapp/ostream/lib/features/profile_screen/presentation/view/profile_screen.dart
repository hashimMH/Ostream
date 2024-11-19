import 'dart:io';

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ostream/global_controller/app_settings_cubit/app_settings_cubit.dart';
import 'package:ostream/global_controller/app_settings_cubit/app_settings_states.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../common_widgets/language_function.dart';
import '../../../../utils/helper/hive_helper.dart';
import '../../../../utils/helper/localization_helper.dart';
import '../../../../utils/resources/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [

            SettingsGroup(
              settingsGroupTitle: translate(context).settings,
              items: [
                SettingsItem(
                  onTap: () {
                    changeLanguage(context, true);
                  },
                  icons: CupertinoIcons.globe,
                  iconStyle: IconStyle(
                    backgroundColor: Theme.of(context).canvasColor,
                    iconsColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  title: translate(context).languages,
                  subtitle: HiveHelper.getLang() == 'ar' ? '🇦🇪' : "🇬🇧",
                ),
                SettingsItem(
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    withBackground: true,
                    backgroundColor: Theme.of(context).canvasColor,
                    iconsColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  title: translate(context).dark_mode,
                  trailing: BlocBuilder<AppSettingsCubit, AppSettingsStates>(
                      builder: (context, state) {
                        return Switch.adaptive(
                          value: AppSettingsCubit.get(context).isDark,
                          onChanged: (value) {
                            AppSettingsCubit.get(context).changeAppMode(value);
                          },
                        );
                      }),
                ),
              ],
            ),
            // SettingsGroup(
            //   settingsGroupTitle: translate(context).activity,
            //   items: [
            //     SettingsItem(
            //       onTap: () {
            //
            //       },
            //       icons: IconlyBold.heart,
            //       iconStyle: IconStyle(
            //         backgroundColor: Theme.of(context).canvasColor,
            //         iconsColor: AppColors.mainColor,
            //       ),
            //       title: translate(context).favorites,
            //     ),
            //     SettingsItem(
            //       onTap: () {
            //
            //       },
            //       icons: CupertinoIcons.group_solid,
            //       iconStyle: IconStyle(
            //           backgroundColor: Theme.of(context).canvasColor,
            //           iconsColor: Theme.of(context).textTheme.bodyLarge!.color),
            //       title: translate(context).following,
            //     ),
            //     SettingsItem(
            //       onTap: () {
            //
            //       },
            //       icons: CupertinoIcons.calendar_badge_plus,
            //       iconStyle: IconStyle(
            //         backgroundColor: Theme.of(context).canvasColor,
            //         iconsColor: Theme.of(context).textTheme.bodyLarge!.color,
            //       ),
            //       title: translate(context).my_bookings,
            //     ),
            //     SettingsItem(
            //       onTap: () {
            //
            //       },
            //       icons: CupertinoIcons.photo_on_rectangle,
            //       iconStyle: IconStyle(
            //         backgroundColor: Theme.of(context).canvasColor,
            //         iconsColor: Theme.of(context).textTheme.bodyLarge!.color,
            //       ),
            //       title: translate(context).my_photo_sessions,
            //     ),
            //   ],
            // ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    // Navigator.of(context).pushNamed(AboutScreen.routeName);
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Theme.of(context).canvasColor,
                    iconsColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  title: translate(context).about,
                ),
              ],
            ),
            // You can add a settings title
            HiveHelper.getToken() == ""
                ? const SizedBox()
                : SettingsGroup(
              settingsGroupTitle: translate(context).account,
              items: [
                SettingsItem(
                  onTap: () {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: translate(context).logout,
                        onConfirmBtnTap: (){},
                        confirmBtnText:
                        translate(context).yes);
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: translate(context).logout,
                ),
                SettingsItem(
                  onTap: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title:
                      translate(context).delete_my_account,
                      onConfirmBtnTap: (){},
                      confirmBtnText: translate(context).yes,
                    );
                  },
                  icons: CupertinoIcons.delete_solid,
                  title: translate(context).delete_my_account,
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
