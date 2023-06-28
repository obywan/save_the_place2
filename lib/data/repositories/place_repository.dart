import '../models/place.dart';

abstract class PlacesRepository {
  Future<List<Place>> getPlaces();
  Future<bool> addPlace(Place p);
  Future<bool> removePlace(Place p);
}
