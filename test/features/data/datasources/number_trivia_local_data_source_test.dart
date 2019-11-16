import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_development/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';

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
    test(
      'should return NumberTrivia From SharedPreferences when there is no one in the cache',
      () async {
        //arange
        when(mockSharedPreferences.getString(any))
            .thenReturn(mockData('trivia_cached.json'));
        //act

        //assert
      },
    );
  });
}
