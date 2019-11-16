import 'package:equatable/equatable.dart';

abstract class NumberTriviaEvent extends Equatable {
  List _props = const <dynamic>[];
  NumberTriviaEvent([_props]);

  @override
  List<Object> get props => [_props];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
