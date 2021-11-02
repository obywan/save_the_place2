import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/models/place.dart';
import '../../helpers/extension_methods.dart';
import '../widgets/compass.dart';
import '../widgets/details_text_row.dart';
import '../widgets/spinny_thing.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String route = '/place_details_screen';
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(title: Text('Details of ${place.name}')),
      body: SafeArea(
        child: Column(
          children: [
            DetailsTextRow(
              text: Text('Name: ${place.name}'),
              color: Colors.green.shade400,
            ),
            DetailsTextRow(
              text: Text('Description: ${place.description}'),
              color: Colors.green.shade300,
            ),
            DetailsTextRow(
              text: Text('Latitude: ${place.location.latitude}'),
              color: Colors.green.shade200,
            ),
            DetailsTextRow(
              text: Text('Longitude: ${place.location.longitude}'),
              color: Colors.green.shade100,
            ),
            DetailsTextRow(
              text: Text('Elevation: ${place.location.elevation}'),
              color: Colors.green.shade50,
            ),
            _getImage(place.imagePath, context)
          ],
        ),
      ),
    );
  }

  Expanded _getImage(String imagePath, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Container(
            // height: 200,
            width: double.infinity,
            child: (imagePath.isNotEmpty)
                ? Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
