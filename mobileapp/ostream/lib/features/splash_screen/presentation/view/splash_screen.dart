import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/helper/hive_helper.dart';
import '../../../../utils/resources/app_assets.dart';
import '../../../landing_screen/presentation/view/landing_screen.dart';
import '../../../layout_screen/presentation/view/layout_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName ='/SplashScreen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
              tag: "background",
              child: Image.asset(AppAssets.background, fit: BoxFit.cover,)),
          AnimatedSplashScreen(
            backgroundColor: Colors.transparent,
            splashTransition: SplashTransition.fadeTransition,
            splash: Hero(
              tag: 'logo',
              child: Image.asset(AppAssets.logo),),
            duration: 4300,
            centered: true,
            splashIconSize: 200,
            nextScreen: HiveHelper.getToken() == ''
                ? const LandingScreen()
                : const LayoutScreen(),
          ),
        ],
      ),
    );
  }
}
