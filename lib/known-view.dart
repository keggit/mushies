import 'package:flutter/material.dart';
import 'package:mushies_2/observations.dart';
import 'package:provider/provider.dart';

import 'observation-sliver.dart';
import 'models/observation.dart';

// this view takes any observations marked 'known'
// and groups them together based on title

class KnownView extends StatelessWidget {
  final _mushrooms = [
    Observation('Psilocybe Cubensis', DateTime.now()),
    Observation('Chicken of the Woods', DateTime.now()),
    Observation('Morchella', DateTime.now(), imagePath: "assets/morel.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    final mushrooms = context
        .watch<Observations>()
        .hiveObs
        .values
        .where((Observation mushroom) => mushroom.known);

    return ListView.builder(
      itemCount: mushrooms.length,
      itemBuilder: (context, index) {
        final mushroom = mushrooms.elementAt(mushrooms.length - index - 1);
        return ObservationSliver(mushroom);
      },
    );
  }
}
