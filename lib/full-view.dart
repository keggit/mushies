//import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'display-image.dart';
import 'observations.dart';

const months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

class FullView extends StatelessWidget {
  final index;

  FullView(this.index);

  @override
  Widget build(BuildContext context) {
    final note = context.watch<Observations>().hiveObs.getAt(index);
    final time = note.timeObserved;

    return Scaffold(
      appBar: AppBar(title: Text(note.name)),
      body: Column(children: [
        note.summary != null ? Text(note.summary) : Container(),
        //Text(this.note?.gillType),
        //Text(this.note?.image.path),
        ListTile(
          title: Text("Found on: "),
          subtitle: Text(
              "${months[time.month - 1]} ${time.day.toString()}, ${time.year.toString()} at ${time.hour.toString()}:${time.minute.toString()}"),
        ),
        note.imagePath == null
            ? Text("no image")
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: displayImage(note.imagePath),
              ),

        note.location == null
            ? Container()
            : ListTile(
                title: Text("With the location: "),
                subtitle: Text(
                    "Latitude: ${note.location.latitude} Longitude: ${note.location.longitude}"),
              ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: note.known
                    ? ElevatedButton(
                        onPressed: () {
                          context.read<Observations>().switchKnown(index);
                        },
                        //Provider.of<Observations>(context, listen: false)
                        //   .addToKnown(key), //addToKnown(context, this.note.key),
                        child: Text("Remove from known"),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          context.read<Observations>().switchKnown(index);
                        },
                        //Provider.of<Observations>(context, listen: false)
                        //   .addToKnown(key), //addToKnown(context, this.note.key),
                        child: Text("Add to known"),
                      ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<Observations>().delete(index);
                    Navigator.pop(context);
                  }, //deleteNote(context, this.note.key),
                  child: Text("delete"),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  addToKnown(BuildContext context, key) {
    context.read<Observations>().switchKnown(key);
  }

  void deleteNote(BuildContext context, key) {
    //context.read<Observations>().delete(key);
    Navigator.pop(context);
  }
}
