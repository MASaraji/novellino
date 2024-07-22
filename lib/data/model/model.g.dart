// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NovelAdapter extends TypeAdapter<Novel> {
  @override
  final int typeId = 1;

  @override
  Novel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Novel(
      url: fields[1] as String,
      title: fields[0] as String,
      siteTitle: fields[3] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Novel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.siteTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
