import 'package:geolocator/geolocator.dart';

import '../data/models/place.dart';

extension PlaceBearing on Position {
  double getBearing(Place p) {
    return Geolocator.bearingBetween(this.latitude, this.longitude, p.location.latitude, p.location.longitude);
  }
}
