import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_development/core/error/exceptions.dart';
import 'package:tdd_development/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:matcher/matcher.dart';

import '../../../mock/mock_data_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(mockData('trivia_cached.json')));

    test(
      'should return NumberTrivia From SharedPreferences when there is no one in the cache',
      () async {
        //arange
        when(mockSharedPreferences.getString(any)).thenReturn(
          mockData('trivia_cached.json'),
        );
        //act
        final result = await dataSource.getLastNumberTrivia();
        //assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a CacheException when there is not a cached value',
      () async {
        //arange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        //act
        final call = dataSource.getLastNumberTrivia;
        //assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(number: 1, text: 'Test Trivia');
    test(
      'should call SharedPreferences to cache the data',
      () async {
        //act
        dataSource.cacheNumberTrivia(tNumberTriviaModel);
        //assert
        final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
        verify(
          mockSharedPreferences.setString(
            CACHED_NUMBER_TRIVIA,
            expectedJsonString,
          ),
        );
      },
    );
  });
}
