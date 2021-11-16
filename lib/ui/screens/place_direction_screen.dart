import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../localization/localizations.dart';
import 'place_details_screen.dart';

import '../../data/models/place.dart';
import '../../helpers/extension_methods.dart';
import '../widgets/compass.dart';
import '../widgets/details_text_row.dart';
import '../widgets/spinny_thing.dart';

class PlaceDirectionScreen extends StatelessWidget {
  static const String route = '/place_direction_screen';
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    final positionStream = Geolocator.getPositionStream(intervalDuration: Duration(seconds: 1));
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
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (place.description.isNotEmpty)
                      Expanded(
                        child: DetailsTextRow(
                          child: Text(place.description),
                          color: Colors.green.shade100,
                        ),
                      ),
                    SizedBox(height: 16),
                    Expanded(
                      flex: 10,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text('${translations.general.distance}: ${distance.getReadableDistance()}'),
                          Compass(bearing: bearing),
                        ],
                      ),
                    ),
                  ],
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
