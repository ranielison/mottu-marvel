import 'package:hive/hive.dart';
import 'package:mottu_marvel/app/core/api/character_response_model.dart';

class HiveService {
  Future<Box<CharacterResponseModel>> get _box async =>
      await Hive.openBox<CharacterResponseModel>('CharacterResponse');

  isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  addData(CharacterResponseModel response) async {
    final box = await _box;

    box.add(response);
  }

  Future<List<CharacterResponseModel>> getAllResponses() async {
    var box = await _box;
    return box.values.toList();
  }
}
