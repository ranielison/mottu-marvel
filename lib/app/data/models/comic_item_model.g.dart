// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComicItemModelAdapter extends TypeAdapter<ComicItemModel> {
  @override
  final int typeId = 3;

  @override
  ComicItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComicItemModel(
      resourceURI: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ComicItemModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.resourceURI)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
