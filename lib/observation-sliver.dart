import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../full-view.dart';
import 'image-card.dart';
import 'models/observation.dart';

class ObservationSliver extends StatelessWidget {
  ObservationSliver(this.observation, this.index);

  final Observation observation;
  final index;

  Widget displayImage(final note) {
    if (kIsWeb)
      return Image.network(note.imagePath);
    else
      return Container(
          height: 200,
          width: 200,
          child: Image.file(
            File(note.imagePath),
          ));
  }

  Widget withImage() {
    final time = observation.timeObserved;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          displayImage(observation),
          Text(observation.name),
        ],
      ),
    );

    ListTile(
      title: Text(observation.name),
      subtitle: Text(
          "${time.year.toString()}-${time.month.toString()}-${time.day.toString()}"),
      trailing: displayImage(observation),
    );
  }

  Widget withoutImage() {
    final time = observation.timeObserved;
    return ListTile(
      title: Text(observation.name),
      subtitle: Text(
          "${time.year.toString()}-${time.month.toString()}-${time.day.toString()}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final time = observation.timeObserved;
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FullView(index),
            ),
          );
        },
        child: observation.imagePath == null
            ? withoutImage()
            : ImageCard(observation) //withImage()
        /*ListTile(
              title: Text(observation.name),
              subtitle: Text(
                  "${time.year.toString()}-${time.month.toString()}-${time.day.toString()}"),
              trailing: observation.imagePath == null
                  ? Text('no image')
                  : displayImage(observation),
            ), */
        );
  }
}
