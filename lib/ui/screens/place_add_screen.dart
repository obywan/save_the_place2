import 'package:flutter/material.dart';
import '../widgets/new_location_form.dart';

class PlaceAddScreen extends StatelessWidget {
  static const String route = '/place_add_screen';

  void _onSuccess(BuildContext context) {
    print('success');
    Navigator.of(context).pop();
  }

  void _onError(BuildContext context) {
    print('error');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('error occured')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: NewLocationForm(
            successCallback: () => _onSuccess(context),
            failCallback: () => _onError(context),
          ),
        ),
      ),
    );
  }
}
