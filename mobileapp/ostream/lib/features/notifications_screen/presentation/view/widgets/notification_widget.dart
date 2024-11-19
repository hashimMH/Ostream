import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/model/notifications_model.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: notification.isRead ? Theme.of(context).cardColor : Theme.of(context).canvasColor,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          notification.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 8),
            Text(
              timeago.format(DateTime.parse(notification.date)),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: Icon(
          notification.isRead ? Icons.check_circle : Icons.circle,
          color: notification.isRead ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
