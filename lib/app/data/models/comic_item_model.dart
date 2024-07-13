import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mottu_marvel/app/domain/entities/comic_item_entity.dart';

part 'comic_item_model.g.dart';

@HiveType(typeId: 3)
class ComicItemModel extends Equatable {
  @HiveField(0)
  final String? resourceURI;

  @HiveField(1)
  final String? name;

  const ComicItemModel({this.resourceURI, this.name});

  ComicItemEntity toEntity() => ComicItemEntity(
        resourceURI: resourceURI,
        name: name,
      );

  ComicItemModel fromJson(Map<String, dynamic> json) {
    return ComicItemModel(
      resourceURI: json['resourceURI'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['resourceURI'] = resourceURI;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [resourceURI, name];
}
