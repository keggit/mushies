import 'package:flutter/material.dart';
import 'package:mushies_2/sliding-panel-controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';

import 'add-observation-slider.dart';
import 'known-view.dart';
import 'my-observations-view.dart';

//PanelController _pc = new PanelController();

class Home extends StatefulWidget {
  Home({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final pc = context.watch<SlidingPanelController>().pc;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          bottom: TabBar(
            // indicator: BoxDecoration(color: Colors.brown[800]),
            indicatorColor: Colors.brown[800],
            // labelColor: Colors.brown[300],
            tabs: [
              Tab(
                text: 'my observations',
              ),
              Tab(text: 'known mushrooms')
            ],
          ),
        ),
        body: SlidingUpPanel(
          controller: pc,
          renderPanelSheet: false,
          panel: AddObservationSlider(pc),
          collapsed: _floatingCollapsed(pc),
          onPanelClosed: () => FocusScope.of(context).unfocus(),
          body: Container(
            //height: con,
            child: TabBarView(
              children: <Widget>[
                MyObservationsView(),
                KnownView(),
              ],
            ),
          ),
        ),
        //floatingActionButton: AddNote(),
      ),
    );
  }
}

Widget _floatingCollapsed(final pc) {
  return Container(
    decoration: BoxDecoration(
      //color: Colors.blueGrey,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
    ),
    margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    child: Center(
      child: IconButton(
        icon: Icon(Icons.add),
        color: Colors.white,
        onPressed: () => pc.open(),
      ),
    ),
  );
}
