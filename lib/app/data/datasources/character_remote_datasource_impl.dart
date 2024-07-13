import 'package:dartz/dartz.dart';
import 'package:mottu_marvel/app/core/api/cache_service.dart';
import 'package:mottu_marvel/app/core/api/character_response_model.dart';
import 'package:mottu_marvel/app/core/api/dio_client.dart';
import 'package:mottu_marvel/app/core/di/injection_container.dart';
import 'package:mottu_marvel/app/data/datasources/character_datasource.dart';
import 'package:mottu_marvel/app/data/models/get_characters_response.dart';
import 'package:mottu_marvel/app/domain/usecases/get_characters.dart';
import 'package:mottu_marvel/app/core/error/failures.dart';

class CharacterRemoteDatasourceImpl implements CharacterDatasource {
  final DioClient _client;

  CharacterRemoteDatasourceImpl(this._client);

  _responseInChache(
    CharacterResponseModel response,
    GetCharactersParams params,
  ) {
    bool sameLimit = response.limit == params.limit;
    bool sameOffset = response.offset == params.offset;
    bool sameTerm = response.term == params.nameStartsWith;

    return sameLimit && sameOffset && sameTerm;
  }

  @override
  Future<Either<Failure, GetCharactersResponse>> getCharacters(
    GetCharactersParams params,
  ) async {
    final hiveService = sl<HiveService>();
    final allResponses = await hiveService.getAllResponses();

    for (CharacterResponseModel r in allResponses) {
      if (_responseInChache(r, params)) {
        return Right(
          GetCharactersResponse(
            limit: r.limit,
            offset: r.offset,
            results: r.characters,
            total: r.total,
            count: r.count,
          ),
        );
      }
    }

    final response = await _client.getRequest(
      '/v1/public/characters',
      queryParameters: {
        'limit': params.limit,
        'offset': params.offset,
        if (params.nameStartsWith?.isNotEmpty ?? false)
          'nameStartsWith': params.nameStartsWith,
      },
      //queryParameters: params.toJson(),
      converter: (response) => const GetCharactersResponse().fromJson(
        response['data'],
      ),
    );

    response.fold(
      (l) {},
      (r) async {
        hiveService.addData(
          CharacterResponseModel(
            limit: params.limit,
            offset: params.offset,
            term: params.nameStartsWith,
            characters: r.results,
            total: r.total,
            count: r.count,
          ),
        );
      },
    );

    return response;
  }
}
