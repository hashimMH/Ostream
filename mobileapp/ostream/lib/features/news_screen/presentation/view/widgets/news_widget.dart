import 'package:flutter/material.dart';
import 'package:ostream/common_widgets/cached_image.dart';
import 'package:ostream/features/news_screen/data/model/new_model.dart';
import 'package:ostream/utils/resources/app_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web_view.dart';

class NewsWidget extends StatelessWidget {
  final Results news;

  const NewsWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebView(
              url: news.link ?? "",
              title: news.title ?? "",
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Theme.of(context).canvasColor,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWidget(
              image: news.imageUrl ?? "",
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title ?? "No Title Available",
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    news.description ?? "No Description Available",
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (news.sourceIcon != null)
                    CachedImageWidget(
                      image: news.sourceIcon ?? "",
                      height: 60,
                      width: 60,
                    ),
                  const SizedBox(height: 8),
                  Text(
                    news.sourceName ?? "Unknown Source",
                    style: AppFonts.bodySmall,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
