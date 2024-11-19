import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app/my_app.dart';
import '../errors/failures.dart';
import '../resources/snackbar_widget.dart';
import 'hive_helper.dart';

// Helper class for common BLoC operations
class BlocHelper {
  // Helper method for data fetching without pagination
  static void fetchData<T>({
    required BuildContext context,
    required Future<Either<Failure, T>> Function({
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    int? id,
    }) fetchFunction,
    int? id,
    required Function(T) onSuccess,
    required Function() onLoading,
    required Function() onError,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) {
    onLoading();

    final headers = {
      'Authorization': HiveHelper.getToken() == '' ? '' : 'token ${HiveHelper.getToken()}',
      "Accept-Language": HiveHelper.getLang(),
    };

    final queryParams = params ?? {"place": HiveHelper.getCity().toLowerCase()};

    fetchFunction(headers: headers, params: queryParams, id: id, body: body).then((value) {
      value.fold((failure) {
        if (failure is OffLineFailure) {
          failSnackBar(AppLocalizations.of(context)!.internet_connection_error, "", navigatorKey.currentState!.context);
        } else if (failure is WrongDataFailure && failure.message != 'Invalid page.') {
          failSnackBar(failure.message.toString(), 'Please, enter your valid data.', navigatorKey.currentState!.context);
        } else if (failure is ServerFailure) {
          failSnackBar(AppLocalizations.of(context)!.server_error, "", navigatorKey.currentState!.context);
        }
        onError();
      }, (data) {
        onSuccess(data);
      });
    });
  }

  // Helper method for data fetching with pagination
  static Future<void> fetchPaginationData<T>({
    required BuildContext context,
    required PaginationState paginationState,
    required Future<Either<Failure, T>> Function({
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    int? id,
    }) fetchFunction,
    int? id,
    required Function(T) onSuccess,
    required Function() onLoading,
    required Function() onError,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) async {
    if (paginationState.isLoading || !paginationState.hasMoreData) return;

    onLoading();
    paginationState.isLoading = true;

    final headers = {
      'Authorization': HiveHelper.getToken() == '' ? '' : 'token ${HiveHelper.getToken()}',
      'Accept-Language': HiveHelper.getLang(),
    };
    final params0 = {"page": paginationState.currentPage};

    final result = await fetchFunction(body: body, params: params?? params0, headers: headers, id: id);

    result.fold((failure) {
      if (failure is OffLineFailure) {
        failSnackBar(AppLocalizations.of(context)!.internet_connection_error, "", navigatorKey.currentState!.context);
      } else if (failure is WrongDataFailure && failure.message != 'Invalid page.') {
        failSnackBar(failure.message.toString(), 'Please, enter your valid data.', navigatorKey.currentState!.context);
      } else if (failure is ServerFailure) {
        failSnackBar(AppLocalizations.of(context)!.server_error, "", navigatorKey.currentState!.context);
      }
      paginationState.isLoading = false;
      onError();
    }, (data) {
      onSuccess(data);
      paginationState.currentPage++; // Increment the page
      paginationState.isLoading = false;
    });
  }
}

// Helper class to manage pagination states
class PaginationState {
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
}
