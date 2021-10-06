import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:save_the_place/data/models/place.dart';
import 'package:save_the_place/ui/widgets/compass.dart';
import 'package:save_the_place/ui/widgets/spinny_thing.dart';
import '../../helpers/extension_methods.dart';

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
      body: Column(
        children: [
          if (imagePath != null && imagePath.isNotEmpty)
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 16),
          if (description != null)
            Text(
              description,
              style: Theme.of(context).textTheme.headline5,
            ),
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
                    children: [
                      Text('Coords: ${place.location.latitude}, ${place.location.longitude}'),
                      Text('Bearing: ${bearing.round()}'),
                      Text('Distance: ${distance.toInt()} m'),
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
    );
  }
}
