import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mottu_marvel/app/core/api/cache_service.dart';
import 'package:mottu_marvel/app/core/api/character_response_model.dart';
import 'package:mottu_marvel/app/core/api/dio_client.dart';
import 'package:mottu_marvel/app/core/di/injection_container.dart' as di;
import 'package:mottu_marvel/app/core/error/failures.dart';
import 'package:mottu_marvel/app/data/datasources/character_remote_datasource_impl.dart';
import 'package:mottu_marvel/app/data/models/character_model.dart';
import 'package:mottu_marvel/app/data/models/comic_item_model.dart';
import 'package:mottu_marvel/app/data/models/comic_model.dart';
import 'package:mottu_marvel/app/data/models/thumbnail_model.dart';
import 'package:mottu_marvel/app/domain/usecases/get_characters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../fixtures/fixture_reader.dart';
import 'character_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([HiveService])
void main() {
  late MockHiveService mockHiveService;
  late CharacterRemoteDatasourceImpl dataSourceImpl;
  late DioAdapter dioAdapter;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            (MethodCall methodCall) async {
      return '.';
    });
    await di.init(isUnitTest: true);
    await Hive.initFlutter('cache');
    Hive.registerAdapter(CharacterResponseModelAdapter());
    Hive.registerAdapter(CharacterModelAdapter());
    Hive.registerAdapter(ComicModelAdapter());
    Hive.registerAdapter(ComicItemModelAdapter());
    Hive.registerAdapter(ThumbnailModelAdapter());

    dioAdapter = DioAdapter(dio: di.sl<DioClient>().dio);
    dataSourceImpl = CharacterRemoteDatasourceImpl(
      di.sl<DioClient>(),
      di.sl<HiveService>(),
    );
    mockHiveService = MockHiveService();
  });

  group('Get Characters', () {
    final getCharactersParams = GetCharactersParams(
      limit: 22,
      offset: 0,
      nameStartsWith: '',
    );

    final jsonResponse =
        json.decode(fixture('get_characters_response_success.json'))
            as Map<String, dynamic>;

    final getCharactersResponse = const CharacterResponseModel().fromJson(
      jsonResponse['data'],
    );

    List<CharacterResponseModel> charactersResponseCache = [
      getCharactersResponse
    ];

    test(
        'should return a GetCharacterResponse object if the status code is 200',
        () async {
      /// arrange
      final decode =
          json.decode(fixture('get_characters_response_success.json'));

      when(mockHiveService.getAllResponses()).thenAnswer(
        (_) async => charactersResponseCache,
      );

      dioAdapter.onGet(
        '/v1/public/characters',
        (server) => server.reply(
          200,
          decode,
        ),
      );

      /// act
      final result = await dataSourceImpl.getCharacters(getCharactersParams);

      /// assert
      result.fold(
        (l) => expect(l, null),
        (r) => expect(r, getCharactersResponse),
      );
    });

    test(
      'should return server failure when response code is 400',
      () async {
        /// arrange

        when(mockHiveService.getAllResponses()).thenAnswer(
          (_) async => const Left(ServerFailure('Erro inesperado')),
        );

        dioAdapter.onPost(
          getCharactersParams.limit != null &&
                  getCharactersParams.offset != null
              ? '/v1/public/characters?limit=${getCharactersParams.limit}&offset=${getCharactersParams.offset}'
              : '/v1/public/characters',
          (server) => server.reply(
            400,
            {},
          ),
        );

        /// act
        final result = await dataSourceImpl.getCharacters(getCharactersParams);

        /// assert
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => expect(r, null),
        );
      },
    );
  });
}
