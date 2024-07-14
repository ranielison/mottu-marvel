import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mottu_marvel/app/core/api/character_response_model.dart';
import 'package:mottu_marvel/app/core/di/injection_container.dart' as di;
import 'package:mottu_marvel/app/core/error/failures.dart';
import 'package:mottu_marvel/app/data/datasources/character_datasource.dart';
import 'package:mottu_marvel/app/data/repositories/character_repository_impl.dart';
import 'package:mottu_marvel/app/domain/usecases/get_characters.dart';

import '../../../fixtures/fixture_reader.dart';
import 'character_repository_impl_test.mocks.dart';

@GenerateMocks([CharacterDatasource])
void main() {
  late MockCharacterDatasource mockCharacterDatasource;
  late CharacterRepositoryImpl charactersRepositoryImpl;

  setUp(() async {
    await di.init(isUnitTest: true);
    mockCharacterDatasource = MockCharacterDatasource();
    charactersRepositoryImpl = CharacterRepositoryImpl(
      mockCharacterDatasource,
    );
  });

  group("Get Characters", () {
    final getCharactersParams = GetCharactersParams(
      limit: 10,
      offset: 10,
      nameStartsWith: '',
    );

    final charactersResponse = const CharacterResponseModel().fromJson(
      json.decode(fixture('get_characters_response_success.json'))
          as Map<String, dynamic>,
    );

    test('should return a GetCharactersResponse when call data is successful',
        () async {
      // arrange

      when(mockCharacterDatasource.getCharacters(getCharactersParams))
          .thenAnswer(
        (_) async => Right(charactersResponse),
      );

      // act
      final result =
          await charactersRepositoryImpl.getCharacters(getCharactersParams);

      verify(mockCharacterDatasource.getCharacters(getCharactersParams));

      expect(result.isRight(), true);
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockCharacterDatasource.getCharacters(getCharactersParams))
            .thenAnswer(
          (_) async => const Left(
            ServerFailure(''),
          ),
        );

        // act
        final result =
            await charactersRepositoryImpl.getCharacters(getCharactersParams);

        // assert
        verify(mockCharacterDatasource.getCharacters(getCharactersParams));
        expect(result, const Left(ServerFailure('')));
      },
    );
  });
}
