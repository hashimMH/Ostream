import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../home_screen/presentation/view/home_screen.dart';
import '../controller/cubit/main_cubit.dart';
import '../controller/cubit/main_state.dart';

class LayoutScreen extends StatelessWidget {
  static const routeName = "/LayoutScreen";
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit ,MainState>(
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return Scaffold(
            body: cubit.screen[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeNavBarIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(IconlyLight.category), label: "requests"),
                  BottomNavigationBarItem(icon: Icon(IconlyLight.paper), label: "ChatPDF"),
                  BottomNavigationBarItem(icon: Icon(IconlyLight.activity), label: "News"),
                  BottomNavigationBarItem(icon: Icon(IconlyLight.setting), label: "Settings"),
                ],
              ),
          );
        }
      ),
    );
  }
}
