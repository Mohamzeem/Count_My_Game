import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class CheckConnection {
  Future<bool> get isConnected;
}

class CheckConnectionImpl implements CheckConnection {
  final InternetConnectionChecker checkConnection;
  CheckConnectionImpl({
    required this.checkConnection,
  });

  @override
  Future<bool> get isConnected => checkConnection.hasConnection;
}
