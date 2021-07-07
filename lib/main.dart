import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mushies_2/tools/colors.dart';
import 'package:mushies_2/observations.dart';
import 'package:mushies_2/sliding-panel-controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'models/observation.dart';

void main() async {
  // this line stops a null error from occuring when fetching the directory
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(ObservationAdapter());
  await Hive.openBox<Observation>('observationsBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Observations()),
        ChangeNotifierProvider(create: (_) => SlidingPanelController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorLight: primaryLightColor,
        //secondaryColor: secondaryColor,
      ),
      home: Home(title: 'Mushies!'),
    );
  }
}

final ThemeData _myTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: primaryColor,
      onPrimary: primaryLightColor,
      secondary: secondaryColor,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backwardsCompatibility: false,
    ),
    scaffoldBackgroundColor: primaryLightColor,
  );
}
