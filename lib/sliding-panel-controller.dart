import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanelController with ChangeNotifier, DiagnosticableTreeMixin {
  PanelController _pc = PanelController();

  get pc => _pc;

  void closePanel(BuildContext context) {
    _pc.close();
    FocusScope.of(context).unfocus();
    notifyListeners();
  }
}
