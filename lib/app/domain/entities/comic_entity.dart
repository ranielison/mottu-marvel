import 'package:equatable/equatable.dart';
import 'package:mottu_marvel/app/domain/entities/comic_item_entity.dart';

class ComicEntity extends Equatable {
  final int? available;
  final String? collectionURI;
  final List<ComicItemEntity>? items;
  final int? returned;

  const ComicEntity({
    this.available,
    this.collectionURI,
    this.items,
    this.returned,
  });

  @override
  List<Object?> get props => [available, collectionURI, items, returned];
}
