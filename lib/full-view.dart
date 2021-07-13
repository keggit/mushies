//import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'display-image.dart';
import 'observations.dart';

class FullView extends StatelessWidget {
  final index;

  FullView(this.index);

  @override
  Widget build(BuildContext context) {
    final note = context.watch<Observations>().hiveObs.getAt(index);

    return Scaffold(
      appBar: AppBar(title: Text(note.name)),
      body: Column(children: [
        Text(note.summary != null ? note.summary : 'no summary'),
        //Text(this.note?.gillType),
        //Text(this.note?.image.path),
        Text(note.timeObserved.toString()),
        note.imagePath == null
            ? Text("no image")
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: displayImage(note.imagePath),
              ),
        note.latitude == null
            ? Text("no latitude")
            : Text(note.latitude.toString()),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: note.known
                    ? Text("this is a known observation")
                    : ElevatedButton(
                        onPressed: () {
                          context.read<Observations>().addToKnown(index);
                        },
                        //Provider.of<Observations>(context, listen: false)
                        //   .addToKnown(key), //addToKnown(context, this.note.key),
                        child: Text("add to known"),
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
    context.read<Observations>().addToKnown(key);
  }

  void deleteNote(BuildContext context, key) {
    //context.read<Observations>().delete(key);
    Navigator.pop(context);
  }
}
