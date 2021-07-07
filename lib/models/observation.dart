import 'package:hive/hive.dart';

part 'observation.g.dart';

@HiveType(typeId: 1)
class Observation {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? summary;
  @HiveField(2)
  String? gillType;
  @HiveField(3)
  String? imagePath;
  @HiveField(4)
  DateTime timeObserved;
  @HiveField(5)
  bool known = false;

  Observation(this.name, this.timeObserved,
      {this.summary, this.gillType, this.imagePath, this.known = false});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'summary': summary,
      'gillType': gillType,
      'imagePath': imagePath,
      'timeObserved': timeObserved,
    };
  }
}
