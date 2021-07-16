import 'dart:io';

import 'package:flutter/material.dart';

import 'models/observation.dart';

class ImageCard extends StatefulWidget {
  final Observation observation;
  final image;

  ImageCard(this.observation)
      : image = Image.file(
          File(observation.imagePath!),
        );

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard>
    with AutomaticKeepAliveClientMixin<ImageCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(widget.image.image, context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            child: Text(
              widget.observation.name,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: widget.image,
          ),
        ],
      ),
    );
  }
}
