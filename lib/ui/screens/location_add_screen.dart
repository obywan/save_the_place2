import 'package:flutter/material.dart';
import 'package:save_the_place/ui/widgets/new_location_form.dart';

class LocationAddScreen extends StatelessWidget {
  static const String route = '/location_add_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: NewLocationForm(),
        ),
      ),
    );
  }
}
