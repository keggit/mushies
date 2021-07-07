import 'package:flutter/foundation.dart';

class AddObservationState with ChangeNotifier, DiagnosticableTreeMixin {
  String _name = "";
  String _imagePath = "";
  String _summary = "";
  String _gillType = "";

  get name => _name;
  get imagePage => _imagePath;
  get summary => _summary;
  get gillType => _gillType;

  void changeName(name) {
    _name = name;
    notifyListeners();
  }

  void changeImage(image) {
    _imagePath = image;
    notifyListeners();
  }

  void changeSummary(summary) {
    _summary = summary;
    notifyListeners();
  }

  void changeGillType(gillType) {
    _gillType = gillType;
    notifyListeners();
  }
}
