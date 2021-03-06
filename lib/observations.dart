import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'models/observation.dart';

class Observations with ChangeNotifier, DiagnosticableTreeMixin {
  List<Observation> _observations = [];
  Box<Observation> _hiveObs = Hive.box<Observation>('observationsBox');

  get observations => _observations;

  get hiveObs => _hiveObs;

  void addNote(name, timeObserved, {image, known, location}) async {
    final obs = Observation(name, timeObserved,
        imagePath: image, known: known, location: location);

    _observations.add(
      Observation(name, timeObserved, imagePath: image, known: known),
    );

    //var box = Hive.box<Observation>('observationsBox');
    _hiveObs.add(Observation(name, timeObserved,
        imagePath: image, known: known, location: location));

    print(obs);

    notifyListeners();
  }

  void switchKnown(index) async {
    final note = _hiveObs.getAt(index);

    if (note != null) {
      final observation = Observation(note.name, note.timeObserved,
          imagePath: note.imagePath, known: !note.known);
      _hiveObs.putAt(index, observation);
    }

    notifyListeners();
  }

  void delete(index) async {
    _hiveObs.deleteAt(index);
    notifyListeners();
  }
}
