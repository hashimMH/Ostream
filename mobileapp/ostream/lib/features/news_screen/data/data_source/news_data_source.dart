import 'package:ostream/features/news_screen/data/model/new_model.dart';

import '../../../../utils/network/dio/enum.dart';
import '../../../../utils/network/network_handler/data_source_handler.dart';

class NewsDataSource{
  Future<NewsModel> getNews({
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    int? id,
  }) async {
    final response = await NetworkUtils.makeRequest(
      endpoint: "https://newsdata.io/api/1/latest?",
      headers: headers,
      params: params,
      body: body,
      method: Method.get.name,
    );
    return NetworkUtils.processResponse(
        response, (data) => NewsModel.fromJson(data));
  }
}