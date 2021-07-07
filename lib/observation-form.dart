import 'package:flutter/material.dart';

class ObservationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(),
          TextFormField(),
          TextFormField(),
          ElevatedButton(
            onPressed: () {},
            child: Text('Submit'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
