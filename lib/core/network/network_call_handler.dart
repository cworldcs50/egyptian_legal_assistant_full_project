import '../error/exceptions.dart';
import 'network_info.dart';
import '../error/failure.dart';
import 'package:fpdart/fpdart.dart';

class NetworkCallHandler {
  const NetworkCallHandler({required this.networkInfo});

  final NetworkInfo networkInfo;

  Future<Either<Failure, T>> call<T>(Future<T> Function() action) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await action();
        return right(result);
      } on ServerException catch (e) {
        return left(ServerFailure(message: e.message ?? ""));
      } catch (e) {
        return left(
          ServerFailure(message: "Unexcepcted Exception: ${e.toString()}"),
        );
      }
    } else {
      return left(
        const NetworkFailure(
          message: "no internet connection, please check internet",
        ),
      );
    }
  }

  Stream<Either<Failure, T>> callStream<T>(Stream<T> Function() action) async* {
    if (await networkInfo.isConnected) {
      try {
        yield* action().map((event) => right<Failure, T>(event)).handleError((e) {
          if (e is ServerException) {
            return left<Failure, T>(ServerFailure(message: e.message ?? ""));
          }
          return left<Failure, T>(
            ServerFailure(message: "Unexcepcted Exception: ${e.toString()}"),
          );
        });
      } catch (e) {
        yield left(
          ServerFailure(message: "Unexcepcted Exception: ${e.toString()}"),
        );
      }
    } else {
      yield left(
        const NetworkFailure(
          message: "no internet connection, please check internet",
        ),
      );
    }
  }
}
