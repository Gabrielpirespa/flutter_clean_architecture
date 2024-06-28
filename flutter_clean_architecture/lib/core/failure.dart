import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get msg;

  @override
  List<Object?> get props => [];
}

//No internet connection
class NoConnectionFailure extends Failure {
  @override
  String get msg => "Sorry! Something is wrong with you connection!";
}

class ServerFailure extends Failure {
  @override
  String get msg => "Sorry! It wasn't possible to access the Server";
}

class ConvertFailure extends Failure {
  @override
  String get msg => "Sorry! Your query isn't in the right format";
}

class AccessLocalDataFailure extends Failure {
  @override
  String get msg => "Sorry! It wasn't possible to access the local data";
}
