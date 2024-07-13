import 'package:hive/hive.dart';
import 'package:mottu_marvel/app/data/models/character_model.dart';

part 'character_response_model.g.dart';

@HiveType(typeId: 0)
class CharacterResponseModel {
  @HiveField(0)
  final int? limit;

  @HiveField(1)
  final int? offset;

  @HiveField(2)
  final int? total;

  @HiveField(3)
  final int? count;

  @HiveField(4)
  final String? term;

  @HiveField(5)
  final List<CharacterModel>? characters;

  CharacterResponseModel({
    required this.limit,
    required this.offset,
    required this.total,
    required this.count,
    this.term,
    required this.characters,
  });
}
