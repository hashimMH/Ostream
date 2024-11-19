import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/helper/hive_helper.dart';
import 'app_settings_states.dart';

class AppSettingsCubit extends Cubit<AppSettingsStates> {
  AppSettingsCubit() : super(ThemeInitialState());

  static AppSettingsCubit get(context) => BlocProvider.of(context);

  String lang = HiveHelper.getLang();

  void changeAppLang(String lang) {
    HiveHelper.setLang(lang);
    emit(ChangeLangState());
  }

  bool isDark = HiveHelper.getMood();

  void changeAppMode(bool value) {
    isDark = value;
    HiveHelper.setMood(isDark);
    emit(ChangeThemeState());
  }
}
