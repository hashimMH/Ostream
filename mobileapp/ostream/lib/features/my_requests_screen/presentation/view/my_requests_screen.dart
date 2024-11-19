import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ostream/features/add_request_screen/presentation/view/add_request_screen.dart';
import 'package:ostream/utils/resources/constants.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../../data/model/my_request_model.dart';
import 'widgets/my_request_widget.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      appBar: SuperAppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: const Text("My Requests"),
        largeTitle: SuperLargeTitle(
          enabled: true,
          largeTitle: "My Requests",
        ),
        actions: TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, AddRequestScreen.routeName);
          },
          icon: const Icon(IconlyLight.paperPlus),
          label: const Text("Add a request"),
        ),
        searchBar: SuperSearchBar(
          enabled: true,
          onChanged: (query) {
            // Search Bar Changes
          },
          onSubmitted: (query) {
            // On Search Bar submitted
          },
          searchResult: MasonryGridView.count(
            padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
            crossAxisCount: MediaQuery.of(context).size.width < 500
                ? 1
                : MediaQuery.of(context).size.width < 1025
                ? 2
                : 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            itemCount: requests.length,
            itemBuilder: (context, index) => RequestWidget(data: requests[index]),
          ),
          // Add other search bar properties as needed
        ),
      ),

      // AppBar(
      //   title: const Text("My Requests"),
      //   actions: [
      //     TextButton.icon(onPressed: (){
      //       Navigator.pushNamed(context, AddRequestScreen.routeName);
      //     }, icon: const Icon(IconlyLight.paperPlus), label: const Text("Add a request"),)
      //   ],
      // ),
      body: MasonryGridView.count(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
        crossAxisCount: MediaQuery.of(context).size.width < 500
            ? 1
            : MediaQuery.of(context).size.width < 1025
                ? 2
                : 3,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        itemCount: requests.length,
        itemBuilder: (context, index) => RequestWidget(data: requests[index]),
      ),
    );
  }
}
