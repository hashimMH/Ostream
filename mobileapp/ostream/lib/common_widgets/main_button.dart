import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/resources/app_colors.dart';

class MainButton extends StatelessWidget {
  final Widget child;
  final Function() fct;
  final Color? color;
  const MainButton({super.key, required this.child, required this.fct, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color?? Theme.of(context).canvasColor,
      onPressed: fct,
      elevation: 0,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }
}
