// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../app/my_app.dart';
//
// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   final _androidChannel = const AndroidNotificationChannel(
//     'fypp_channel_id',
//     'High Importance Notifications',
//     description: 'This channel is used for important notification',
//     importance: Importance.max,
//   );
//   final _localNotifications = FlutterLocalNotificationsPlugin();
//
//   Future<void> handleMessage(RemoteMessage? message) async {
//     if (message == null) return;
//     if(message.category == 'project' || message.data['category'] == 'project'){
//       // navigatorKey.currentState?.pushNamed(CompoundScreen.routeName, arguments: message.data['id'],);
//     } else if(message.category == 'property' || message.data['category'] == 'property')
//       {
//         // navigatorKey.currentState?.pushNamed(UnitDetailsScreen.routeName, arguments: message.data['id'],);
//       }
//   }
//
//   Future initialLocalNotifications() async {
//     const iOS = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('@mipmap/fypp');
//     const settings = InitializationSettings(
//       android: android,
//       iOS: iOS,
//     );
//     await _localNotifications.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (payload) {
//         final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
//         handleMessage(message);
//       },
//     );
//     final platform = _localNotifications.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }
//
//
//
//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             importance: Importance.max,
//             priority: Priority.max,
//             playSound: true,
//             showWhen: true,
//             enableVibration: true,
//             icon: '@mipmap/fypp',
//           ),
//         ),
//         payload: jsonEncode(message.toMap()),
//       );
//     });
//   }
//
//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     initPushNotifications();
//     initialLocalNotifications();
//   }
// }
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }
//
//
//
//
