import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ostream/common_widgets/main_button.dart';
import 'package:ostream/features/news_screen/presentation/controller/controller/news_cubit.dart';
import 'package:ostream/features/news_screen/presentation/controller/controller/news_state.dart';
import 'package:ostream/features/news_screen/presentation/view/widgets/news_widget.dart';
import 'package:ostream/utils/resources/app_colors.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../../../utils/resources/constants.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit()..getNews(context, "top"),
      child: BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return SuperScaffold(
          appBar: SuperAppBar(
            backgroundColor: Theme.of(context).canvasColor,
            title: const Text("Last News"),
            largeTitle: SuperLargeTitle(
              enabled: true,
              largeTitle: "News",
            ),
            searchBar: SuperSearchBar(
              enabled: true,
              onSubmitted: (query) {
                cubit.getNews(context, "top", search: query);
              },
              searchResult: state is GetNewsLoadingState || cubit.newsModel == null
                  ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
                  : cubit.newsModel!.results!.isEmpty? const Text("Empty") :  MasonryGridView.count(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.pagePadding),
                crossAxisCount: MediaQuery.of(context).size.width < 500
                    ? 1
                    : MediaQuery.of(context).size.width < 1025
                    ? 2
                    : 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                itemCount: cubit.newsModel!.results!.length,
                itemBuilder: (BuildContext context, int index) => NewsWidget(
                  news: cubit.newsModel!.results![index],
                ),
              ),
            ),
            bottom: SuperAppBarBottom(
              enabled: true,
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => TextButton(
                      child: Text(categories[index]), onPressed: () {
                        cubit.getNews(context, categories[index]);
                  })),
            ),
          ),
          body: state is GetNewsLoadingState || cubit.newsModel == null
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : cubit.newsModel!.results!.isEmpty? const Text("Empty") : MasonryGridView.count(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.pagePadding),
                  crossAxisCount: MediaQuery.of(context).size.width < 500
                      ? 1
                      : MediaQuery.of(context).size.width < 1025
                          ? 2
                          : 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  itemCount: cubit.newsModel!.results!.length,
                  itemBuilder: (BuildContext context, int index) => NewsWidget(
                    news: cubit.newsModel!.results![index],
                  ),
                ),
        );
      }),
    );
  }
}

final List<String> categories = [
  "Top",
  "Sports",
  "Technology",
  "Business",
  "Science",
  "Entertainment",
  "Health",
  "World",
  "Politics",
  "Environment",
  "Food",
];
