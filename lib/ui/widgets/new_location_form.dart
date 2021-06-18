import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/places_bloc.dart';
import '../../data/models/location.dart';
import '../../data/models/place.dart';
import '../../helpers/form_validators.dart';
import 'image_selector.dart';

class NewLocationForm extends StatefulWidget {
  final Function successCallback;
  final Function failCallback;

  const NewLocationForm(
      {Key? key, required this.successCallback, required this.failCallback})
      : super(key: key);
  @override
  _NewLocationFormState createState() => _NewLocationFormState();
}

class _NewLocationFormState extends State<NewLocationForm> {
  static const String name = 'name';
  static const String desc = 'desc';
  static const String path = 'path';

  final _formKey = GlobalKey<FormState>();
  Map<String, String> vals = {name: '', desc: '', path: ''};

  void _setPath(String p) {
    vals[path] = p;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      debugPrint(vals[path]);
      BlocProvider.of<PlacesBloc>(context, listen: false).add(
        AddPlace(
          Place(Location(49.560, 25.599, 0), vals[name] ?? 'без назви',
              vals[desc], ''),
        ),
      );
    }
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _initial(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _submitForm(context),
        child: Text('Save'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onSaved: (value) =>
                    vals[name] = value != null ? value : 'без назви',
                validator: FormValidators.notEmpty,
                decoration: InputDecoration(hintText: 'Place name (required)'),
              ),
              SizedBox(height: 8),
              TextFormField(
                onSaved: (value) => vals[desc] = value != null ? value : '',
                decoration:
                    InputDecoration(hintText: 'Place description (optional)'),
              ),
              SizedBox(height: 24),
              ImageSelector(callback: _setPath),
            ],
          ),
        ),
        SizedBox(height: 24),
        BlocConsumer<PlacesBloc, PlacesState>(
          listener: (context, state) {
            if (state is PlacesAdded) widget.successCallback();
            if (state is PlacesError) widget.failCallback();
          },
          builder: (context, state) {
            if (state is PlacesLoading)
              return _loading();
            else if (state is PlacesInitial || state is PlacesLoaded)
              return _initial(context);

            return Container();
          },
        ),
      ],
    );
  }
}
