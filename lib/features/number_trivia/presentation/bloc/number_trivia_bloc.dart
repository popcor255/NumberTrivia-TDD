import 'dart:async';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:tdd_development/core/util/input_converter.dart';
import 'package:tdd_development/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_development/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required this.getConcreteNumberTrivia,
    @required this.getRandomNumberTrivia,
    @required this.inputConverter,
  }) {
    assert(getConcreteNumberTrivia != null);
    assert(getRandomNumberTrivia != null);
    assert(inputConverter != null);
  }

  @override
  NumberTriviaState get initialState => InitialNumberTriviaState;

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final input = inputConverter.stringToUnsignedInteger(event.numberString);

      yield* input.fold(
        (failure) async* {
          yield Error(
            message: INVALID_INPUT_FAILURE_MESSAGE,
          );
        },
        (integer) => throw prefix0.UnimplementedError(),
      );
      yield Error(message: 'Invalid Input');
    }
  }
}
