// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComicModelAdapter extends TypeAdapter<ComicModel> {
  @override
  final int typeId = 2;

  @override
  ComicModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComicModel(
      available: fields[0] as int?,
      collectionURI: fields[1] as String?,
      items: (fields[2] as List?)?.cast<ComicItemModel>(),
      returned: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ComicModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.available)
      ..writeByte(1)
      ..write(obj.collectionURI)
      ..writeByte(2)
      ..write(obj.items)
      ..writeByte(3)
      ..write(obj.returned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
