import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ostream/global_controller/app_settings_cubit/app_settings_cubit.dart';
import '../../features/add_request_screen/presentation/view/add_request_screen.dart';
import '../../features/chatbot_screen/presentation/chatbot_screen.dart';
import '../../features/landing_screen/presentation/view/landing_screen.dart';
import '../../features/layout_screen/presentation/view/layout_screen.dart';
import '../../features/notifications_screen/presentation/view/notifications_screen.dart';
import '../../features/request_details_screen/presentation/view/request_details_screen.dart';
import '../../features/splash_screen/presentation/view/splash_screen.dart';
import '../../features/trends_screen/presentation/view/trends_screen.dart';
import '../../global_controller/app_settings_cubit/app_settings_states.dart';
import '../helper/hive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../resources/theme_controller.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppSettingsCubit>(
          create: (BuildContext context) => AppSettingsCubit(),
        ),
      ],
      child: BlocBuilder<AppSettingsCubit, AppSettingsStates>(
        builder: (context, state) {
        return  MaterialApp(
          navigatorKey: navigatorKey,
          title: 'ADEO',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale: Locale(HiveHelper.getLang()),
          theme: Styles.themeData(HiveHelper.getMood(), context),
          // home: SignInDemo(),
          home: const SplashScreen(),
          // home: HiveHelper.getToken() == '' ? const OnBoardingScreen() : const SplashScreen(),
          routes: {
            SplashScreen.routeName: (ctx) => const SplashScreen(),
            LandingScreen.routeName: (ctx) => const LandingScreen(),
            LayoutScreen.routeName: (ctx) => const LayoutScreen(),
            NotificationsScreen.routeName: (ctx) => const NotificationsScreen(),
            RequestDetailsScreen.routeName: (ctx) => RequestDetailsScreen(),
            AddRequestScreen.routeName: (ctx) => const AddRequestScreen(),
            ChatBotScreen.routeName: (ctx) => const ChatBotScreen(),
            TrendsScreen.routeName: (ctx) => const TrendsScreen(),

          },
        );
      }),
    );
  }
}
