import 'package:internet_connection_checker/internet_connection_checker.dart';

//check if we connect to internet or not
abstract class NetworkInfo {
  const NetworkInfo();

  Future<bool> get isConnected;
}

//to work on Dependency inversion, dependency injection

class NetworkInfoImp implements NetworkInfo {
  const NetworkInfoImp(this.connectionChecker);

  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
