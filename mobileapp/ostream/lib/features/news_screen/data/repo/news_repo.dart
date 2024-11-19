import 'package:dartz/dartz.dart';
import 'package:ostream/features/news_screen/data/model/new_model.dart';

import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';
import '../../../../utils/network/network_handler/repo_handler.dart';
import '../data_source/news_data_source.dart';

class NewsRepo {
  NetworkInfo networkInfo;
  NewsDataSource newsSource;

  NewsRepo({required this.networkInfo, required this.newsSource});

  Future<Either<Failure, NewsModel>> getNews({
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    int? id,
  }) async {
    return await NetworkHandler.getData(
          () => newsSource.getNews(
        body: body,
        headers: headers,
        params: params,
        id: id,
      ),
      networkInfo,
    );
  }
}