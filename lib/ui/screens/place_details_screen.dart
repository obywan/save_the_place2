import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/models/place.dart';
import '../widgets/details_text_row.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String route = '/place_details_screen';
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: SafeArea(
        child: Column(
          children: [
            DetailsTextRow(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.description_outlined),
                  SizedBox(width: 8),
                  Text(place.description),
                ],
              ),
              color: Colors.green.shade300,
            ),
            DetailsTextRow(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 8),
                  Text('${place.location.latitude}, ${place.location.longitude}'),
                ],
              ),
              color: Colors.green.shade200,
            ),
            DetailsTextRow(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.height),
                  SizedBox(width: 8),
                  Text('${place.location.elevation} m'),
                ],
              ),
              color: Colors.green.shade100,
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
