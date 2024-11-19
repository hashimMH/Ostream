import 'package:flutter/material.dart';
import 'package:ostream/utils/resources/app_colors.dart';

import '../../../../../common_widgets/fade_animation.dart';
import '../../../../../common_widgets/headline_row.dart';
import '../../../../../utils/resources/constants.dart';

class TrendsWidget extends StatelessWidget {
  final List<String> trends;
  const TrendsWidget({super.key, required this.trends});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      children: trends.map((trend) => TrendWidget(text: trend)).toList(),
    );
  }
}

// Dummy data for Today's Trends
List<String> todaysTrends = [
  "AbuDhabiCorniche",
  "LouvreAbuDhabi",
  "YasMarina",
  "SheikhZayedGrandMosque",
  "MangroveWalk",
];

// Dummy data for Monthly Trends
List<String> monthlyTrends = [
  "AbuDhabiSkyline",
  "QasrAlWatan",
  "EmiratesPalace",
  "SaadiyatIsland",
  "AbuDhabiGrandPrix",
];

class TrendWidget extends StatelessWidget {
  final String text;
  const TrendWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppColors.lightColor.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("#$text"),
      ),
    );
  }
}

