import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../bloc/places/places_bloc.dart';
import '../../data/models/location.dart' as loc;
import '../../data/models/place.dart';
import '../../data/repositories/location_repository.dart';
import '../../helpers/extension_methods.dart';
import '../../helpers/form_validators.dart';
import '../../localization/localizations.dart';
import '../../localization/translations.i69n.dart';
import 'image_selector.dart';
import 'spinny_thing.dart';

class NewLocationForm extends StatefulWidget {
  final Function successCallback;
  final Function failCallback;

  const NewLocationForm({Key? key, required this.successCallback, required this.failCallback}) : super(key: key);
  @override
  _NewLocationFormState createState() => _NewLocationFormState();
}

class _NewLocationFormState extends State<NewLocationForm> {
  static const String name = 'name';
  static const String desc = 'desc';
  static const String path = 'path';
  static const String lat = 'lat';
  static const String lon = 'lon';
  static const String alt = 'alt';

  final TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> vals = {name: '', desc: '', path: '', lat: 49.49, lon: 25.25, alt: 350.0};

  void _setPath(String p) {
    vals[path] = p;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      BlocProvider.of<PlacesBloc>(context, listen: false).add(
        AddPlace(
          Place(loc.Location(latitude: vals[lat], longitude: vals[lon], elevation: vals[alt]), vals[name], vals[desc], vals[path]),
        ),
      );
    }
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _initial(BuildContext context, Translations tr) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _submitForm(context),
        child: Text(tr.general.save),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = CustomLocalizations.of(context);
    return FutureBuilder<Position>(
      future: LocationRepository.determinePosition(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError)
            return Center(
              child: Text(translations.messages.errorMessage),
            );
          else
            textEditingController.text = DateFormat('HH:mm, MMMM dd yyyy').format(DateTime.now());
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) => vals[name] = value != null ? value : 'noname',
                      validator: FormValidators.notEmpty,
                      // initialValue: ,
                      decoration: InputDecoration(
                          hintText: '${translations.newPlaceForm.name} ${translations.newPlaceForm.required}', labelText: translations.newPlaceForm.name),
                      controller: textEditingController,
                      onTap: () => textEditingController.selectAll(),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) => vals[lat] = value != null ? double.tryParse(value) : 0,
                      validator: FormValidators.notEmpty,
                      initialValue: snapshot.data!.latitude.toStringAsFixed(5),
                      decoration: InputDecoration(
                          hintText: '${translations.newPlaceForm.lat} ${translations.newPlaceForm.required}', labelText: translations.newPlaceForm.lat),
                    ),
                    VerticalDivider(),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) => vals[lon] = value != null ? double.tryParse(value) : 0,
                      validator: FormValidators.notEmpty,
                      initialValue: snapshot.data!.longitude.toStringAsFixed(5),
                      decoration: InputDecoration(
                          hintText: '${translations.newPlaceForm.lon} ${translations.newPlaceForm.required}', labelText: translations.newPlaceForm.lon),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) => vals[alt] = value != null ? double.tryParse(value) : 0,
                      validator: FormValidators.notEmpty,
                      initialValue: snapshot.data!.altitude.toStringAsFixed(1),
                      decoration: InputDecoration(hintText: translations.newPlaceForm.elev, labelText: translations.newPlaceForm.elev),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      onSaved: (value) => vals[desc] = value != null ? value : '',
                      decoration: InputDecoration(hintText: translations.newPlaceForm.description),
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
                  else if (state is PlacesInitial || state is PlacesLoaded || state is PlacesError) return _initial(context, translations);

                  return Container();
                },
              ),
            ],
          );
        } else
          return SpinnyThing();
      },
    );
  }
}
