import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  //true has connection
  //false don't have connection
  //para realizar a verificação se tem internet usar o package internet_connection_checker
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected async =>
      await internetConnectionChecker.hasConnection;
}
