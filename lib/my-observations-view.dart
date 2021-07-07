import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'observation-sliver.dart';
import 'observations.dart';

class MyObservationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Observations>().hiveObs;

    return Container(
      // height: 500,
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          //display newest item first
          final note = notes.getAt(notes.length - index - 1);
          if (note != null)
            return ObservationSliver(note);
          else
            return Text('bad juju');
        },
      ),
    );
  }
}
