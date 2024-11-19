import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../chat_with_pdf_screen/presentation/view/chat_with_pdf_screen.dart';
import '../../../../home_screen/presentation/view/home_screen.dart';
import '../../../../my_requests_screen/presentation/view/my_requests_screen.dart';
import '../../../../news_screen/presentation/view/news_screen.dart';
import '../../../../profile_screen/presentation/view/profile_screen.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  final List<Widget> screen = [
    HomeScreen(),
    MyRequestsScreen(),
    ChatPDFScreen(),
    NewsScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  void changeNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }
}
