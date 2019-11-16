import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_development/core/error/exceptions.dart';
import 'package:tdd_development/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../mock/mock_data_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttp(dynamic data, int statusCode) {
    when(
      mockHttpClient.get(any, headers: anyNamed('headers')),
    ).thenAnswer(
      (_) async => http.Response(data, statusCode),
    );
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      jsonDecode(
        mockData('trivia.json'),
      ),
    );
    test(
      '''should perform a GET request on a URL with number 
      being the endpoint and with application/json header''',
      () async {
        //arange
        setUpMockHttp(mockData('trivia.json'), 200);
        //act
        dataSource.getConcreteNumberTrivia(tNumber);
        //assert
        verify(
          mockHttpClient.get(
            'http://numbersapi.com/$tNumber',
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        //arange
        setUpMockHttp(mockData('trivia.json'), 200);
        //act
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        //assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404',
      () async {
        //arange
        setUpMockHttp('Something went wrong', 404);
        //act
        final call = dataSource.getConcreteNumberTrivia;
        //assert
        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      jsonDecode(
        mockData('trivia.json'),
      ),
    );
    test(
      '''should perform a GET request on a URL with number 
      being the endpoint and with application/json header''',
      () async {
        //arange
        setUpMockHttp(mockData('trivia.json'), 200);
        //act
        dataSource.getRandomNumberTrivia();
        //assert
        verify(
          mockHttpClient.get(
            'http://numbersapi.com/random',
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        //arange
        setUpMockHttp(mockData('trivia.json'), 200);
        //act
        final result = await dataSource.getRandomNumberTrivia();
        //assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404',
      () async {
        //arange
        setUpMockHttp('Something went wrong', 404);
        //act
        final call = dataSource.getRandomNumberTrivia;
        //assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}