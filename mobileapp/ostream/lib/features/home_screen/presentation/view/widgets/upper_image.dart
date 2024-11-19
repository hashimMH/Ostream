import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostream/common_widgets/fade_animation.dart';
import 'package:ostream/features/notifications_screen/presentation/view/notifications_screen.dart';
import 'package:ostream/utils/resources/app_assets.dart';
import 'package:ostream/utils/resources/app_colors.dart';
import 'package:ostream/utils/resources/app_icons.dart';
import 'package:ostream/utils/resources/constants.dart';

class UpperImageSliver extends StatelessWidget {
  const UpperImageSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, NotificationsScreen.routeName);
        }, icon: SvgPicture.asset(AppIcons.notification))
      ],
      backgroundColor: AppColors.lightColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            image: DecorationImage(
              image: AssetImage(AppAssets.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FadeAnimation(
                0.2,
                Image.asset(AppAssets.logo, height: 100),
              ),
              // Large logo when expanded
              const SizedBox(height: AppConstants.spaceBetween),
              FadeAnimation(
                0.4,
                Image.asset(AppAssets.logoWord, height: 80),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        collapseMode: CollapseMode.parallax, // Smooth collapsing effect
      ),
      title: const Text("ADEO"),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
