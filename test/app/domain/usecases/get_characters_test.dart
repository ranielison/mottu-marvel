import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mottu_marvel/app/core/api/character_response_model.dart';
import 'package:mottu_marvel/app/core/error/failures.dart';
import 'package:mottu_marvel/app/domain/repositories/character_repository.dart';
import 'package:mottu_marvel/app/domain/usecases/get_characters.dart';

import '../../../fixtures/fixture_reader.dart';
import 'get_characters_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  late MockCharacterRepository mockCharacterRepository;
  late GetCharacters getCharacters;

  late CharacterResponseModel charactersResponse;

  setUp(() {
    final jsonResponse = (json.decode(
      fixture(
        'get_characters_response_success.json',
      ),
    ) as Map<String, dynamic>);

    charactersResponse = const CharacterResponseModel().fromJson(
      jsonResponse['data'],
    );

    mockCharacterRepository = MockCharacterRepository();
    getCharacters = GetCharacters(mockCharacterRepository);
  });

  group('Get Characters', () {
    test("Should get a list of characters from repository", () async {
      final params = GetCharactersParams(
        limit: 10,
        offset: 0,
        nameStartsWith: '',
      );

      /// arrange
      when(
        mockCharacterRepository.getCharacters(params),
      ).thenAnswer(
        (_) async => Right(charactersResponse),
      );

      /// act
      final result = await getCharacters(params);

      /// assert
      verify(mockCharacterRepository.getCharacters(any));

      result.fold(
        (l) => expect(l, null),
        (r) => expect(r, charactersResponse),
      );
    });

    test("Should return error when repo throw an exception", () async {
      final params = GetCharactersParams(
        limit: 10,
        offset: 0,
        nameStartsWith: '',
      );

      /// arrange
      when(
        mockCharacterRepository.getCharacters(params),
      ).thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await getCharacters(params);

      /// assert
      verify(mockCharacterRepository.getCharacters(any));
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });
}
