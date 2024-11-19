import 'package:flutter/material.dart';
import 'package:ostream/features/notifications_screen/presentation/view/widgets/notification_widget.dart';
import 'package:ostream/utils/resources/constants.dart';

import '../../data/model/notifications_model.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = "/NotificationsScreen";

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
        itemCount: dummyNotifications.length,
        itemBuilder: (context, index) {
          return NotificationWidget(
            notification: dummyNotifications[index],
          );
        },
      ),
    );
  }
}
