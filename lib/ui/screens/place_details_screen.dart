import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/models/place.dart';
import '../../helpers/extension_methods.dart';
import '../widgets/compass.dart';
import '../widgets/spinny_thing.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String route = '/place_details_screen';
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    final positionStream = Geolocator.getPositionStream(intervalDuration: Duration(seconds: 1));

    final imagePath = place.imagePath != null ? place.imagePath : '';
    final description = place.description;
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<Position>(
              stream: positionStream,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final Position? currentLocation = snapshot.data;
                  if (currentLocation != null) {
                    final bearing = currentLocation.getBearing(place);
                    final distance =
                        Geolocator.distanceBetween(currentLocation.latitude, currentLocation.longitude, place.location.latitude, place.location.longitude);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailsTextRow(
                              text: Text('Destination: ${place.location.latitude.toStringAsFixed(4)}, ${place.location.longitude.toStringAsFixed(4)}'),
                              color: Colors.amber,
                            ),
                            DetailsTextRow(
                              text: Text('Bearing: ${bearing.round()}'),
                              color: Colors.green,
                            ),
                            DetailsTextRow(
                              text: Text('Distance: ${distance.toInt()} m'),
                              color: Colors.pink,
                            ),
                          ],
                        ),
                        Compass(bearing: bearing),
                      ],
                    );
                  } else
                    return Text('Waiting for current location...');
                } else {
                  return SpinnyThing();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded _getImage(String? imagePath, String? description, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Container(
            // height: 200,
            width: double.infinity,
            child: (imagePath != null && imagePath.isNotEmpty)
                ? Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          if (description != null && description.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              // height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white70),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DetailsTextRow extends StatelessWidget {
  const DetailsTextRow({
    Key? key,
    required this.text,
    this.color = Colors.grey,
  }) : super(key: key);

  final Text text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(color: color),
      child: text,
    );
  }
}
