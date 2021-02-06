// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../star_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StarDataAdapter extends TypeAdapter<StarData> {
  @override
  final int typeId = 1;

  @override
  StarData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StarData()
      ..name = fields[0] as String
      ..temperature = fields[1] as double
      ..radius = fields[2] as double
      ..mass = fields[3] as double
      ..age = fields[4] as double;
  }

  @override
  void write(BinaryWriter writer, StarData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.radius)
      ..writeByte(3)
      ..write(obj.mass)
      ..writeByte(4)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StarDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}