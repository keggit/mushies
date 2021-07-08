import 'dart:io';

import 'package:flutter/material.dart';

import 'models/observation.dart';

class ImageCard extends StatelessWidget {
  final Observation observation;

  ImageCard(this.observation);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Text(observation.name),
          observation.summary == null
              ? Container()
              : Text(
                  observation.summary!,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.file(
              File(observation.imagePath!),
            ),
          ),
        ],
      ),
    );
  }
}
