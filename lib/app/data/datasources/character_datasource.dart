import 'package:dartz/dartz.dart';
import 'package:mottu_marvel/app/core/api/character_response_model.dart';
import 'package:mottu_marvel/app/domain/usecases/get_characters.dart';
import 'package:mottu_marvel/app/core/error/failures.dart';

abstract class CharacterDatasource {
  Future<Either<Failure, CharacterResponseModel>> getCharacters(
    GetCharactersParams params,
  );
}
