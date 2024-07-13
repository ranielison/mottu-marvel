// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterResponseModelAdapter
    extends TypeAdapter<CharacterResponseModel> {
  @override
  final int typeId = 0;

  @override
  CharacterResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterResponseModel(
      limit: fields[0] as int?,
      offset: fields[1] as int?,
      total: fields[2] as int?,
      count: fields[3] as int?,
      term: fields[4] as String?,
      characters: (fields[5] as List?)?.cast<CharacterModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CharacterResponseModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.limit)
      ..writeByte(1)
      ..write(obj.offset)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.term)
      ..writeByte(5)
      ..write(obj.characters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
