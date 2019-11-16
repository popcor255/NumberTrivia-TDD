import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  List properties = const <dynamic>[];
  Failure([properties]);

  @override
  // TODO: implement props
  List<Object> get props => [this.properties];
}

//General Failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
