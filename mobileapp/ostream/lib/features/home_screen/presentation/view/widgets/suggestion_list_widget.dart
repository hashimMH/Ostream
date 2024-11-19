import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ostream/utils/resources/app_fonts.dart';
import 'package:ostream/utils/resources/constants.dart';
import '../../../../../common_widgets/item_line.dart';
import '../../../../../common_widgets/read_more_widget.dart';
import '../../../data/model/home_suggestions_model.dart';

class SuggestionListSliver extends StatelessWidget {
  const SuggestionListSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => SuggestionWidget(
          data: suggestions[index],
        ),
        childCount: suggestions.length, // Number of items in the list
      ),
    );
  }
}

class SuggestionWidget extends StatelessWidget {
  final HomeSuggestionModel data;

  const SuggestionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.pagePadding, vertical: 5),
      color: Theme.of(context).canvasColor,
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(data.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadMoreWidget(text: data.description),
            const SizedBox(
              height: AppConstants.spaceBetween,
            ),
            ItemLine(
              icon: IconlyLight.location,
              text: data.location,
            ),
            const SizedBox(height: 7,),
            Text(data.creationDate, style: AppFonts.bodySmall,),
          ],
        ),
      ),
    );
  }
}
