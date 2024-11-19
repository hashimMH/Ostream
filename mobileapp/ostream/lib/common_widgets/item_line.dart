import 'package:flutter/material.dart';

class ItemLine extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String text;
  final TextStyle? style;
  final Color? iconColor;
  final int? maxLine;
  const ItemLine({super.key, required this.icon, required this.text, this.style, this.iconColor, this.maxLine, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      // textBaseline: TextBaseline.alphabetic,
      children: [
        Icon(icon, color: iconColor, size: iconSize,),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            text,
            style: style,
            maxLines: maxLine,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
