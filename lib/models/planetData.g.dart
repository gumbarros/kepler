// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planetData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanetDataAdapter extends TypeAdapter<PlanetData> {
  @override
  final int typeId = 0;

  @override
  PlanetData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanetData(
      planetName: fields[0] as String,
      orbitalPeriod: fields[1] as double,
      star: fields[2] as String,
      jupiterMass: fields[3] as double,
      density: fields[4] as double,
      radius: fields[5] as double,
      discoveryMethod: fields[6] as int,
      telescope: fields[7] as String,
      numOfPlanetsSystem: fields[8] as int,
    )
      ..bband = fields[9] as double
      ..vband = fields[10] as double
      ..bmvj = fields[11] as double;
  }

  @override
  void write(BinaryWriter writer, PlanetData obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.planetName)
      ..writeByte(1)
      ..write(obj.orbitalPeriod)
      ..writeByte(2)
      ..write(obj.star)
      ..writeByte(3)
      ..write(obj.jupiterMass)
      ..writeByte(4)
      ..write(obj.density)
      ..writeByte(5)
      ..write(obj.radius)
      ..writeByte(6)
      ..write(obj.discoveryMethod)
      ..writeByte(7)
      ..write(obj.telescope)
      ..writeByte(8)
      ..write(obj.numOfPlanetsSystem)
      ..writeByte(9)
      ..write(obj.bband)
      ..writeByte(10)
      ..write(obj.vband)
      ..writeByte(11)
      ..write(obj.bmvj);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanetDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
