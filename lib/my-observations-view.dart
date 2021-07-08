import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'observation-sliver.dart';
import 'observations.dart';

class MyObservationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Observations>().hiveObs;

    return Container(
      // height: 500,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        staggeredTileBuilder: (index) =>
            index == 0 ? StaggeredTile.fit(1) : const StaggeredTile.fit(1),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          //display newest item first
          final note = notes.getAt(notes.length - index - 1);
          if (note != null)
            return ObservationSliver(note, notes.length - index - 1);
          else
            return Text('bad juju');
        },
      ),
    );
  }
}
