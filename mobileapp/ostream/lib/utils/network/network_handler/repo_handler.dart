import 'package:dartz/dartz.dart';

import '../../errors/exceptions.dart';
import '../../errors/failures.dart';
import '../connection/network_info.dart';

class NetworkHandler {
  // Reusable method to handle data fetching and error handling
  static Future<Either<Failure, T>> getData<T>(
    Future<T> Function() getDataFunction, // Function to call for data
    NetworkInfo networkInfo,
    // Network information instance to check connectivity
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await getDataFunction();
        return right(result);
      } on WrongDataException catch (e) {
        return left(WrongDataFailure(message: e.message));
      } on ServerException {
        return left(ServerFailure());
      }
      // catch (e) {
      //   print(e);
      //   return left(ServerFailure());
      // }
    } else {
      return left(OffLineFailure());
    }
  }
}
