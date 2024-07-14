import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mottu_marvel/app/data/models/comic_item_model.dart';
import 'package:mottu_marvel/app/domain/entities/comic_entity.dart';

part 'comic_model.g.dart';

@HiveType(typeId: 2)
class ComicModel extends Equatable {
  @HiveField(0)
  final int? available;

  @HiveField(1)
  final String? collectionURI;

  @HiveField(2)
  final List<ComicItemModel>? items;

  @HiveField(3)
  final int? returned;

  const ComicModel({
    this.available,
    this.collectionURI,
    this.items,
    this.returned,
  });

  ComicEntity toEntity() => ComicEntity(
        available: available,
        collectionURI: collectionURI,
        items: items?.map((item) => item.toEntity()).toList(),
        returned: returned,
      );

  ComicModel fromJson(Map<String, dynamic> json) {
    final items = <ComicItemModel>[];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(const ComicItemModel().fromJson(v));
      });
    }

    return ComicModel(
      available: json['available'] is String ? null : json['available'],
      collectionURI: json['collectionURI'],
      items: items,
      returned: json['returned'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['available'] = available;
    data['collectionURI'] = collectionURI;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['returned'] = returned;
    return data;
  }

  @override
  List<Object?> get props => [available, collectionURI, items, returned];
}
