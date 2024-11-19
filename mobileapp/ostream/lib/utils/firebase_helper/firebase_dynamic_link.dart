// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:layaly/features/details_screen/presentation/view/details_screen.dart';
// import 'package:layaly/features/offer_collection_details_screen/presentation/view/offer_collection_details_screen.dart';
// import 'package:layaly/features/reels_from_share_screen/presentation/view/reels_from_share_screen.dart';
// import 'package:layaly/features/vendor_screen/presentation/view/vendor_screen.dart';
// import 'package:share_plus/share_plus.dart';
//
// class FirebaseDynamicLinkServices {
//   static final FirebaseDynamicLinks _dynamicLinks =
//       FirebaseDynamicLinks.instance;
//   static const String _uriPrefix = 'https://layalyy.page.link';
//   static const String _packageName = 'com.layaly.layaly';
//   static const String _iosBundleId = "com.layaly.layaly";
//
//   /// Builds and shares dynamic links
//   static Future<String> buildDynamicLink({
//     required String kind,
//     required String title,
//     required String image,
//     required int docId,
//     required bool short,
//   }) async {
//     try {
//       final Uri link = Uri.parse('https://www.layaly.com/$kind?id=$docId');
//       final DynamicLinkParameters parameters =
//           _buildLinkParameters(link, title, image);
//
//       Uri dynamicUrl = short
//           ? (await _dynamicLinks.buildShortLink(parameters)).shortUrl
//           : await _dynamicLinks.buildLink(parameters);
//
//       Share.share(dynamicUrl.toString(), subject: title);
//       return dynamicUrl.toString();
//     } catch (e) {
//       print('Error building dynamic link: $e');
//       return '';
//     }
//   }
//
//   /// Initializes and handles the dynamic link on app startup
//   static Future<void> initDynamicLink(BuildContext context) async {
//     try {
//       final PendingDynamicLinkData? data = await _dynamicLinks.getInitialLink();
//       if (data != null) {
//         _handleDeepLink(data.link, context);
//       }
//     } catch (e) {
//       print('Error initializing dynamic link: $e');
//     }
//   }
//
//   /// Helper to build dynamic link parameters
//   static DynamicLinkParameters _buildLinkParameters(
//       Uri link, String title, String image) {
//     return DynamicLinkParameters(
//       uriPrefix: _uriPrefix,
//       link: link,
//       androidParameters: const AndroidParameters(
//         packageName: _packageName,
//         minimumVersion: 0,
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: _iosBundleId,
//         minimumVersion: '0',
//       ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: title,
//         imageUrl: Uri.parse(image),
//         description: '',
//       ),
//     );
//   }
//
//   /// Handles the deep link and routes to the correct screen
//   static void _handleDeepLink(Uri deepLink, BuildContext context) {
//     final String? id = deepLink.queryParameters['id'];
//     if (id == null) {
//       print('Invalid deep link, no id found');
//       return;
//     }
//
//     final int docId = int.parse(id);
//     if (deepLink.pathSegments.contains('item')) {
//       _navigateTo(context, DetailsScreen.routeName, docId);
//     } else if (deepLink.pathSegments.contains('collection')) {
//       _navigateTo(context, OfferCollectionDetailsScreen.routeName, docId);
//     } else if (deepLink.pathSegments.contains('vendor')) {
//       _navigateTo(context, VendorScreen.routeName, docId);
//     } else if (deepLink.pathSegments.contains('reel')) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ReelsFromShareScreen(
//             id: docId,
//           ),
//         ),
//       );
//     } else {
//       print('Unknown deep link path: ${deepLink.path}');
//     }
//   }
//
//   /// Simplified navigation handler
//   static void _navigateTo(BuildContext context, String routeName, int id) {
//     try {
//       Navigator.pushNamed(context, routeName, arguments: id);
//     } catch (e) {
//       print('Error navigating to $routeName: $e');
//     }
//   }
// }
