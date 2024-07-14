import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mottu_marvel/app/data/models/character_model.dart';

part 'character_response_model.g.dart';

@HiveType(typeId: 0)
class CharacterResponseModel extends Equatable {
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

  const CharacterResponseModel({
    this.limit,
    this.offset,
    this.total,
    this.count,
    this.term,
    this.characters,
  });

  CharacterResponseModel fromJson(Map<String, dynamic> json) {
    final characters = <CharacterModel>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        characters.add(const CharacterModel().fromJson(v));
      });
    }

    return CharacterResponseModel(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      term: json['term'],
      count: json['count'],
      characters: characters,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['offset'] = offset;
    data['limit'] = limit;
    data['total'] = total;
    data['term'] = term;
    data['count'] = count;
    if (characters != null) {
      data['results'] = characters!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        offset,
        limit,
        total,
        count,
        term,
        characters,
      ];
}
