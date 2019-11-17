import 'package:equatable/equatable.dart';
import 'package:tdd_development/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:meta/meta.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

NumberTriviaState get InitialNumberTriviaState => Empty();

class Empty extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
