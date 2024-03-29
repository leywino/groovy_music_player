// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyAdapter extends TypeAdapter<Recently> {
  @override
  final int typeId = 3;

  @override
  Recently read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recently(
      songname: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      id: fields[4] as int?,
      songurl: fields[3] as String?,
      index: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Recently obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songurl)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
