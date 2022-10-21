import '../models/location.dart';
import '../models/place.dart';
import 'place_repository.dart';

class FakePlacesRepository extends PlacesRepository {
  List<Place> fakePlaces = [
    Place(Location(latitude: 49.547, longitude: 25.635, elevation: 0.0), 'Збаразьке кільце', 'Центр збаразького кільця, де зараз роблять ремонт', '',
        DateTime(2021, 10, 1), ['city', 'road']),
    Place(Location(latitude: 49.157, longitude: 25.704, elevation: 0.0), 'Дім', 'Точка біля воріт в селі', '', DateTime(2021, 10, 1), ['city', 'home']),
    Place(Location(latitude: 49.560, longitude: 25.599, elevation: 0.0), '6 магазин', 'Шостий магазин на Бродівській', '', DateTime(2021, 10, 1),
        ['city', 'road']),
  ];

  @override
  Future<List<Place>> getPlaces() async {
    await Future.delayed(Duration(seconds: 1));
    return fakePlaces;
  }

  @override
  Future<bool> addPlace(Place p) async {
    fakePlaces.add(p);
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> removePlace(Place p) async {
    fakePlaces.remove(p);
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Set<String> getTags() {
    return fakePlaces.map((e) => e.tags).fold({}, (previousValue, element) {
      previousValue.addAll(element);
      return previousValue;
    });
  }
}
