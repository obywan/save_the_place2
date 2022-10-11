import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/models/place.dart';
import '../../helpers/extension_methods.dart';
import '../../localization/localizations.dart';
import '../widgets/compass.dart';
import '../widgets/details_text_row.dart';
import '../widgets/spinny_thing.dart';
import 'place_details_screen.dart';

class PlaceDirectionScreen extends StatelessWidget {
  static const String route = '/place_direction_screen';

  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    final positionStream = Geolocator.getPositionStream();
    final translations = CustomLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        actions: [
          IconButton(onPressed: () => Navigator.of(context).pushNamed(PlaceDetailsScreen.route, arguments: place), icon: Icon(Icons.info)),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<Position>(
          stream: positionStream,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final Position? currentLocation = snapshot.data;
              if (currentLocation != null) {
                final bearing = currentLocation.getBearing(place);
                final distance =
                    Geolocator.distanceBetween(currentLocation.latitude, currentLocation.longitude, place.location.latitude, place.location.longitude);
                return Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(alignment: Alignment.center, child: Text('${translations.general.distance}: ${distance.getReadableDistance()}')),
                      Compass(bearing: bearing),
                    ],
                  ),
                );
              } else
                return Text(translations.general.waitingForLocation);
            } else {
              return SpinnyThing();
            }
          },
        ),
      ),
    );
  }
}
