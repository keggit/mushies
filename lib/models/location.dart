// Hive storage data type of the 'Position'
// Object from the Geolocator package

import 'package:hive/hive.dart';

part 'location.g.dart';

@HiveType(typeId: 2)
class Location {
  @HiveField(0)
  double longitude;
  @HiveField(1)
  double latitude;
  @HiveField(2)
  DateTime? timeStamp;
  @HiveField(3)
  double accuracy;
  @HiveField(4)
  double altitude;
  @HiveField(5)
  double heading;
  @HiveField(6)
  double speed;
  @HiveField(7)
  double speedAccuracy;

  Location({
    required this.longitude,
    required this.latitude,
    this.timeStamp,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.speedAccuracy,
  });
}
