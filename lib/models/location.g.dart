// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 2;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      longitude: fields[0] as double,
      latitude: fields[1] as double,
      timeStamp: fields[2] as DateTime?,
      accuracy: fields[3] as double,
      altitude: fields[4] as double,
      heading: fields[5] as double,
      speed: fields[6] as double,
      speedAccuracy: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.longitude)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.timeStamp)
      ..writeByte(3)
      ..write(obj.accuracy)
      ..writeByte(4)
      ..write(obj.altitude)
      ..writeByte(5)
      ..write(obj.heading)
      ..writeByte(6)
      ..write(obj.speed)
      ..writeByte(7)
      ..write(obj.speedAccuracy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
