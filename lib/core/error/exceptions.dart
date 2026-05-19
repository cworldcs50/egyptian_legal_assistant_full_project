//deal with datalayer
class ServerException implements Exception {
  const ServerException({this.message});

  final String? message;
}

class CacheException implements Exception {
  const CacheException({this.message = "Error in local database"});

  final String message;
}

class OfflineException implements Exception {
  const OfflineException({this.message = "you are offline"});

  final String message;
}

class UnauthorizedException implements Exception {
  const UnauthorizedException({
    this.message = "you are unauthorized to access",
  });

  final String message;
}
