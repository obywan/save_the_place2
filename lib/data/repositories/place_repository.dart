import '../models/place.dart';

abstract class PlacesResitory {
  Future<List<Place>> getPlaces();
  Future<bool> addPlace(Place p);
  Future<bool> removePlace(Place p);
}
