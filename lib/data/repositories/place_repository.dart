import '../models/location.dart';
import '../models/place.dart';

abstract class PlacesResitory {
  Future<List<Place>> getPlaces();
  Future<bool> addPlace(Place p);
}

class FakePlaceRepository extends PlacesResitory {
  List<Place> fakePlaces = [
    Place(Location(49.547, 25.635, 0), 'Збаразьке кільце',
        'Центр збаразького кільця, де зараз роблять ремонт', ''),
    Place(Location(49.157, 25.704, 0), 'Дім', 'Точка біля воріт в селі', ''),
    Place(Location(49.560, 25.599, 0), '6 магазин',
        'Шостий магазин на Бродівській', ''),
  ];

  Future<List<Place>> getPlaces() async {
    await Future.delayed(Duration(seconds: 1));
    return fakePlaces;
  }

  Future<bool> addPlace(Place p) async {
    fakePlaces.add(p);
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
