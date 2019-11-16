import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_development/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        //arange
        final str = '123';
        //act
        final result = inputConverter.stringToUnsignedInteger(str);
        //assert
        expect(result, Right(123));
      },
    );

    test(
      'should return a failure when it is not an integer',
      () async {
        //arange
        final str = '1.0';
        //act
        final result = inputConverter.stringToUnsignedInteger(str);
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      'should return a failure integer is less than zero',
      () async {
        //arange
        final str = '-123';
        //act
        final result = inputConverter.stringToUnsignedInteger(str);
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
