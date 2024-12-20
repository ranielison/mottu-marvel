import 'package:dartz/dartz.dart';
import 'package:mottu_marvel/app/core/api/character_response_model.dart';
import 'package:mottu_marvel/app/data/datasources/character_datasource.dart';
import 'package:mottu_marvel/app/domain/repositories/character_repository.dart';
import 'package:mottu_marvel/app/domain/usecases/get_characters.dart';
import 'package:mottu_marvel/app/core/error/failures.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  /// Data Source
  final CharacterDatasource characterRemoteDatasource;

  const CharacterRepositoryImpl(this.characterRemoteDatasource);

  @override
  Future<Either<Failure, CharacterResponseModel>> getCharacters(
    GetCharactersParams params,
  ) async {
    final response = await characterRemoteDatasource.getCharacters(params);

    return response.fold(
      (failure) => Left(failure),
      (charactersResponse) => Right(charactersResponse),
    );
  }
}
