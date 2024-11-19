import 'package:flutter/material.dart';
import 'package:ostream/features/layout_screen/presentation/view/layout_screen.dart';
import 'package:ostream/utils/resources/app_assets.dart';
import 'package:ostream/utils/resources/constants.dart';

import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/resources/app_colors.dart';
import '../../../../../utils/resources/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common_widgets/fade_animation.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = "/LandingScreen";

  const LandingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Hero(
              tag: 'background',
              child: Image.asset(
                AppAssets.background,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 140,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Hero(
                    tag: "logo",
                    child: Image.asset(
                      AppAssets.logo,
                      height: 260,
                    ),
                  ),
                  const SizedBox(
                    height: AppConstants.spaceBetween,
                  ),
                  FadeAnimation(
                    0.5,
                    Image.asset(
                      AppAssets.logoWord,
                      width: 380,
                    ),
                  ),
                ],
              ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FadeAnimation(
        0.5,
        FloatingActionButton.extended(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LayoutScreen.routeName, (Route<dynamic> route) => false);
          },
          label: const Text(
            "Sign in with UAE PASS",
            style: AppFonts.buttonFont1,
          ),
          icon: Image.asset(
            AppAssets.uaePass,
            height: 30,
          ),
        ),
      ),
    );
  }
}
