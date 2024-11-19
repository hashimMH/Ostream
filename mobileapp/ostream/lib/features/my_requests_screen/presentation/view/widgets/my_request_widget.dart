import 'package:flutter/material.dart';
import 'package:ostream/features/my_requests_screen/data/model/my_request_model.dart';
import 'package:ostream/features/request_details_screen/presentation/view/request_details_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/resources/app_colors.dart';

class RequestWidget extends StatelessWidget {
  final MyRequestsModel data;
  const RequestWidget({super.key, required this.data});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).canvasColor,
      child: ListTile(
        onTap: (){
          Navigator.pushNamed(context, RequestDetailsScreen.routeName, arguments: data);
        },
        title: Text(data.title),
        subtitle: Text("Status: ${data.status}"),
        trailing: Column(
          children: [
            const Text("Last update"),
            Text(
              timeago.format(
                DateTime.parse(data.lastUpdate),
                locale: HiveHelper.getLang(),
              ),
            ),
          ],
        ),
        leading: Icon(
          Icons.info_outline, // You can customize the icon if needed
          color: AppColors.getStatusColor(data.status),
        ),
        tileColor: AppColors.getStatusColor(data.status).withOpacity(0.1), // Add some color opacity to background
      ),
    );
  }
}
