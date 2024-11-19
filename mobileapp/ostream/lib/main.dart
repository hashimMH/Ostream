
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'utils/app/my_app.dart';
import 'utils/bloc_observer/bloc_observer.dart';
import 'utils/di/injection.dart';
import 'utils/firebase_helper/notification_api.dart';
import 'utils/helper/hive_helper.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'env.dart';

late PackageInfo packageInfo;
late ChatGpt chatGpt;

void main() async {
  chatGpt = ChatGpt(apiKey: Env.openAiApiKey);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  //
  // await FirebaseApi().initNotifications();
  await initAppInjection();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.boxKeyUserData);
  await Hive.openBox(HiveHelper.email);
  await Hive.openBox(HiveHelper.password);
  await Hive.openBox(HiveHelper.userToken);
  await Hive.openBox(HiveHelper.mood);
  await Hive.openBox(HiveHelper.lang);
  await Hive.openBox(HiveHelper.city);

  Bloc.observer = MyBlocObserver();
  packageInfo = await PackageInfo.fromPlatform();
  runApp(const MyApp());
}
