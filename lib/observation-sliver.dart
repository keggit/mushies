import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../full-view.dart';
import 'models/observation.dart';

class ObservationSliver extends StatelessWidget {
  ObservationSliver(this.observation);

  final Observation observation;

  Widget displayImage(final note) {
    if (kIsWeb)
      return Image.network(note.imagePath);
    else
      return Container(
          height: 50,
          width: 50,
          child: Image.file(
            File(note.imagePath),
          ));
  }

  @override
  Widget build(BuildContext context) {
    final time = observation.timeObserved;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FullView(observation),
          ),
        );
      },
      child: ListTile(
        title: Text(observation.name),
        subtitle: Text(
            "${time.year.toString()}-${time.month.toString()}-${time.day.toString()}"),
        trailing: observation.imagePath == null
            ? Text('no image')
            : displayImage(observation),
      ),
    );
  }
}
