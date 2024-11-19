import 'package:flutter/material.dart';
import 'package:ostream/common_widgets/headline_row.dart';
import 'package:ostream/features/home_screen/presentation/view/widgets/trends_banner.dart';
import 'package:ostream/utils/resources/app_assets.dart';
import 'package:ostream/utils/resources/constants.dart';
import '../../../../common_widgets/fade_animation.dart';
import '../../../chatbot_screen/presentation/chatbot_screen.dart';
import 'widgets/suggestion_list_widget.dart';
import 'widgets/trends_widget.dart';
import 'widgets/upper_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const UpperImageSliver(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.pagePadding),
                  child: Column(
                    children: [
                      const SizedBox(height: AppConstants.spaceBetween),
                      FadeAnimation(
                        0.1,
                        const HeadLineRow(title: "Today Trends"),
                      ),
                      const SizedBox(height: AppConstants.spaceBetween),
                      FadeAnimation(0.2, TrendsWidget(trends: todaysTrends,)),
                      const SizedBox(height: AppConstants.spaceBetween),
                      FadeAnimation(
                        0.3,
                        const HeadLineRow(title: "Monthly Trends"),
                      ),
                      const SizedBox(height: AppConstants.spaceBetween),
                      FadeAnimation(0.4, TrendsWidget(trends: monthlyTrends,)),
                      const SizedBox(height: AppConstants.spaceBetween),
                      TrendsBanner(),
                      const SizedBox(height: AppConstants.spaceBetween),
                      FadeAnimation(
                        0.4,
                        HeadLineRow(title: "AI Suggestions", actionTitle: "Ask AI", fct: (){
                          Navigator.pushNamed(context, ChatBotScreen.routeName);
                        },),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SuggestionListSliver(), // Add SuggestionList as a Sliver
        ],
      ),
    );
  }
}
