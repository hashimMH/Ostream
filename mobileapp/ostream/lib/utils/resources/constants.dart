import 'package:intl/intl.dart';

import '../helper/hive_helper.dart';

class AppConstants{
  static const String countryCode =   '+971';
  static const String currency =   'AED';
  static const double pagePadding = 16;
  static const double borderRadius = 20;
  static const double spaceBetween = 17;
}
///dateTime format
var formatter = NumberFormat("#,##0", "en_US");
var format = DateFormat('d MMMM yyyy', HiveHelper.getLang());
var timeFormat = DateFormat.jm('en');
///dateTime format
const String serverErrorMessage = 'Please, try again, there an error right now.';
const String internetErrorMessage = 'Please, check your internet connection';
const String valueErrorMessage = 'Please, enter valid value.';
const String testProfileImage = 'https://static2.bigstockphoto.com/9/5/2/large1500/259323481.jpg';
const String testImage = 'https://img.freepik.com/free-photo/young-couple-marriage-photo-session-outside_1303-16698.jpg?t=st=1724752969~exp=1724756569~hmac=8f759c6369e4798af606f7481ebad25e6157ca92770925e902bd7e88c219e88e&w=1800';