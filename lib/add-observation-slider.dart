import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'observations.dart';
import 'sliding-panel-controller.dart';
import 'observation-form.dart';
import 'models/observation.dart';
import 'get-location.dart';

class AddObservationSlider extends StatefulWidget {
  AddObservationSlider(this.pc);

  final pc;

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddObservationSlider> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _subcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _known = false;
  bool _location = false;

  String? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    _subcontroller.dispose();
    super.dispose();
  }

  void _clear() {
    setState(() {
      _subcontroller.clear();
      _controller.clear();
      _image = null;
      _known = false;
      _location = false;
    });
  }

  void check(bool? value) {
    setState(() {
      _known = value!;
    });
  }

  Future<void> checkLocation(bool? value) async {
    print('in funtion');
    if (_location == false) {
      print('location false');
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.denied)
          setState(
            () {
              _location = value!;
            },
          );
      } else {
        setState(
          () {
            _location = value!;
          },
        );
      }
    } else {
      setState(
        () {
          _location = value!;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.amber,
            ),
          ]),
      margin: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          //ObservationForm(_formKey),
          Center(
            child: Container(
              margin: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text('Add Occurance'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "provide a name for the observation",
                    ),
                    controller: _controller,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "summary",
                    ),
                    maxLines: 3,
                    controller: _subcontroller,
                  ),
                  Row(
                    children: [
                      _image == null
                          ? Row(
                              children: [
                                Center(child: Text("add photo")),
                                IconButton(
                                  icon: Icon(Icons.add_a_photo),
                                  onPressed: getImage,
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Icon(Icons.check, color: Colors.green),
                                IconButton(
                                  icon: Icon(Icons.add_a_photo),
                                  onPressed: getImage,
                                ),
                              ],
                            ),
                      Text("Get Location: "),
                      Checkbox(
                          value: _location,
                          onChanged: (value) => checkLocation(value)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Are you sure of what you found? "),
                      Checkbox(
                          value: _known, onChanged: (value) => check(value)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () => context
                                .read<SlidingPanelController>()
                                .closePanel(context),
                            child: Text("close form"),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            child: Icon(Icons.add),
                            onPressed: () async {
                              if (_location) {
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);
                                context.read<Observations>().addNote(
                                      _controller.text,
                                      DateTime.now(),
                                      image: _image,
                                      known: _known,
                                      latitude: position.latitude,
                                    );
                              } else {
                                context.read<Observations>().addNote(
                                    _controller.text, DateTime.now(),
                                    image: _image, known: _known);
                              }
                              _clear();
                              //closes the panel
                              this.widget.pc.close(); //unfocuses any text
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      /*Center(
        child: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text('Add Occurance'),
              TextFormField(
                controller: _controller,
              ),
              TextFormField(
                controller: _subcontroller,
              ),
              _image == null
                  ? IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: getImage,
                    )
                  : Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        IconButton(
                          icon: Icon(Icons.add_a_photo),
                          onPressed: getImage,
                        ),
                      ],
                    ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  context
                      .read<Observations>()
                      .addNote(_controller.text, DateTime.now(), image: _image);
                  _clear();
                  //closes the panel
                  this.widget.pc.close(); //unfocuses any text
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}
