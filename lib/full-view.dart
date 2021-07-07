//import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'display-image.dart';
import 'observations.dart';

class FullView extends StatelessWidget {
  final note;

  FullView(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.note.name)),
      body: Column(children: [
        Text(this.note.summary != null ? this.note.summary : 'no summary'),
        //Text(this.note?.gillType),
        //Text(this.note?.image.path),
        Text(this.note.timeObserved.toString()),
        note.imagePath == null
            ? Text("no image")
            : displayImage(note.imagePath),
        this.note.known
            ? Text("this is a known observation")
            : ElevatedButton(
                onPressed: () => addToKnown(context, this.note.key),
                child: Text("add to known"),
              ),
      ]),
    );
  }
}

addToKnown(BuildContext context, key) {
  context.read<Observations>().addToKnown(key);
}
