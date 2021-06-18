import 'package:location/location.dart';

abstract class LocationRepository {
  LocationData getCurrentLocation();
}
