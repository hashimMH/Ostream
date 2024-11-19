import 'package:flutter/material.dart';


class AppColors {
  static const Color mainColor =  Color(0xffCEC4AC);
  static const Color darkColor =  Color(0xff6F6454);
  static const Color lightColor =  Color(0xffCFC6AA);
  static const Color accentColor = Color(0xFF030D23);
  static const Color accentBackground =  Color(0xffece4dc);
  static const Color white = Colors.white;
  static const Color grayColor = Color(0xffEBEBEB);

  static Color getStatusColor(String status) {
    switch (status) {
      case "Waiting for Review":
        return Colors.orange; // You can choose an appropriate color
      case "In Review":
        return Colors.blue;
      case "Accepted":
        return Colors.green;
      case "In Progress":
        return Colors.amber;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
