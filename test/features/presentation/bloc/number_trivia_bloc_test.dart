import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_development/core/util/input_converter.dart';
import 'package:tdd_development/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_development/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_development/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_development/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:tdd_development/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd_development/features/number_trivia/presentation/bloc/number_trivia_state.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test(
    'initialState should be Empty',
    () async {
      //assert
      expect(bloc.initialState, equals(Empty()));
    },
  );

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParse = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test Trivia');

    test(
      'should call the InputConverter to valid and convert the string to an unsigned integer',
      () async {
        //arange
        when(mockInputConverter.stringToUnsignedInteger((any)))
            .thenReturn(Right(tNumberParse));
        //act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any))
            .timeout(const Duration(seconds: 60));
        //assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        //arange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        //assert later
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];

        expectLater(
          bloc.asBroadcastStream(),
          emitsInOrder(expected),
        );
        //act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
      },
    );
  });
}
