// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThumbnailModelAdapter extends TypeAdapter<ThumbnailModel> {
  @override
  final int typeId = 4;

  @override
  ThumbnailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThumbnailModel(
      path: fields[0] as String?,
      extension: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ThumbnailModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.extension);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThumbnailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
