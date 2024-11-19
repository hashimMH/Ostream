import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostream/common_widgets/main_button.dart';
import 'package:ostream/features/trends_screen/presentation/view/trends_screen.dart';

import '../../../../../utils/resources/app_assets.dart';

class TrendsBanner extends StatelessWidget {
  const TrendsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Image.asset(AppAssets.trendsBanner),
          PositionedDirectional(
            top: 10,
            end: 10,
            child: MainButton(
              fct: (){
                Navigator.pushNamed(context, TrendsScreen.routeName);
              },
              child: const Text("Trends Chart"),
            ),
          )
        ],
      ),
    );
  }
}
