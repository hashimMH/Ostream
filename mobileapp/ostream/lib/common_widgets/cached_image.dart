import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/resources/app_assets.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key? key,
    this.color,
    required this.image,
    this.height,
    this.width,
  }) : super(key: key);

  final String image;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: image,
      height: height,
      width: width,
      color: color,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Theme.of(context).canvasColor,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: const Center(
            child: Icon(Icons.broken_image),
          ),
        ),
      ),
    );
  }
}
