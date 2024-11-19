
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';






class HiveHelper {
  static const boxKeyUserData = "boxKeyUserSit";
  static const userToken = "userTokenSit";
  static const mood = 'mood';
  static const lang = 'lang';
  static const city = 'city';
  static const email = 'phoneOrCode';
  static const password = 'password';

  static void setNew(bool isDark) {
    Hive.box(HiveHelper.mood).put(HiveHelper.mood, isDark);
  }

  static bool getNew() {
    return Hive.box(HiveHelper.mood).isNotEmpty
        ? Hive.box(HiveHelper.mood).get(HiveHelper.mood)
        : true;
  }

  // static AuthModel? getUserData() {
  //   return Hive.box(HiveHelper.boxKeyUserData).isNotEmpty
  //       ? userModelFromJson(
  //     Hive.box(HiveHelper.boxKeyUserData).get(HiveHelper.boxKeyUserData),
  //   )
  //       : null;
  // }

  // static void setUserData(AuthModel userModel) async {
  //   Hive.box(HiveHelper.boxKeyUserData)
  //       .put(HiveHelper.boxKeyUserData, userModelToJson(userModel));
  // }
  static void setEmail(String phoneOrCode) {
    Hive.box(HiveHelper.email).put(HiveHelper.email, phoneOrCode);
  }

  static String getEmail() {
    return Hive.box(HiveHelper.email).isNotEmpty
        ? Hive.box(HiveHelper.email).get(HiveHelper.email)
        : '';
  }

  static void setPassword(String password) {
    Hive.box(HiveHelper.password).put(HiveHelper.password, password);
  }

  static String getPassword() {
    return Hive.box(HiveHelper.password).isNotEmpty
        ? Hive.box(HiveHelper.password).get(HiveHelper.password)
        : '';
  }

  static void setLang(String lang) {
    Hive.box(HiveHelper.lang).put(HiveHelper.lang, lang);
  }

  static String getLang() {
    return Hive.box(HiveHelper.lang).isNotEmpty
        ? Hive.box(HiveHelper.lang).get(HiveHelper.lang)
        : 'ar';
  }


  static void setCity(String city) {
    Hive.box(HiveHelper.city).put(HiveHelper.city, city);
  }

  static String getCity() {
    return Hive.box(HiveHelper.city).isNotEmpty
        ? Hive.box(HiveHelper.city).get(HiveHelper.city)
        : 'Qena';
  }

  static void setMood(bool isDark) {
    Hive.box(HiveHelper.mood).put(HiveHelper.mood, isDark);
  }

  static bool getMood() {
    return Hive.box(HiveHelper.mood).isNotEmpty
        ? Hive.box(HiveHelper.mood).get(HiveHelper.mood)
        : false;
  }


  static void setToken(String token) {
    Hive.box(HiveHelper.userToken).put(HiveHelper.userToken, token);
  }

  static String getToken() {
    return Hive.box(HiveHelper.userToken).isNotEmpty
        ? Hive.box(HiveHelper.userToken).get(HiveHelper.userToken)
        : '';
  }



  static bool getModeState() {
    return Hive.box(HiveHelper.mood).isNotEmpty
        ? Hive.box(HiveHelper.mood).get(HiveHelper.mood)
        : false;
  }

  static void setModeState(bool isDark) {
    Hive.box(HiveHelper.mood).put(HiveHelper.mood, isDark);
  }

  // static void logout(BuildContext context) {
  //   Hive.box(boxKeyUserData).clear();
  //   Hive.box(userToken).clear();
  //   Navigator.of(context)
  //       .pushNamedAndRemoveUntil(OnboardingScreen.routeName, (Route<dynamic> route) => false);
  // }



}
