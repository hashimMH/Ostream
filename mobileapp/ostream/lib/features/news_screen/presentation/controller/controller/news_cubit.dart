import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ostream/features/news_screen/data/data_source/news_data_source.dart';
import 'package:ostream/features/news_screen/data/model/new_model.dart';
import 'package:ostream/features/news_screen/data/repo/news_repo.dart';
import 'package:ostream/utils/di/injection.dart';
import 'package:ostream/utils/network/connection/network_info.dart';

import '../../../../../utils/helper/bloc_helper.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  final NewsRepo _repo = NewsRepo(
    networkInfo: instance<NetworkInfoImp>(),
    newsSource: NewsDataSource(),
  );


  NewsModel? newsModel;

  void getNews(BuildContext context, String category, {String? search}) async {
    return BlocHelper.fetchData(
      context: context,
      fetchFunction: _repo.getNews,
      params: search != null? {
        "q" : search,
        "country" : "ae",
        "apikey" : "pub_5962797d464a65506aac71ad79f1975615e9b",
      } : {
        "country" : "ae",
        "category" : category,
        "apikey" : "pub_5962797d464a65506aac71ad79f1975615e9b",

      },
      onSuccess: (NewsModel data) {
        newsModel = data;
        emit(GetNewsSuccessState());
      },
      onLoading: () => emit(GetNewsLoadingState()),
      onError: () => emit(GetNewsErrorState()),
    );
  }
}
