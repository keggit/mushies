import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Widget displayImage(final imagePath) {
  if (kIsWeb)
    return Image.network(imagePath);
  else
    return Image.file(
      File(imagePath),
    );
}
