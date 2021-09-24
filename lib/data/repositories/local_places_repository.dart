import 'dart:convert';

import '../../helpers/local_storage_helper.dart';
import '../models/place.dart';
import 'place_repository.dart';

class LocalPlacesRepository extends PlacesResitory {
  static const String filename = 'places.json';
  List<Place> places = [];
  bool _initialLoadIsDone = false;

  @override
  Future<bool> addPlace(Place p) async {
    places.add(p);
    final placesJson = json.encode(places);
    await LocalStorageHelper.saveToFile(filename, placesJson);
    return true;
  }

  @override
  Future<List<Place>> getPlaces() async {
    if (!_initialLoadIsDone) {
      await _initLoad();
    }
    return places;
  }

  Future<void> _initLoad() async {
    try {
      final stringData = await LocalStorageHelper.readFile(filename);
      if (stringData.isNotEmpty) {
        places = List<Place>.from((jsonDecode(stringData) as Iterable).map((e) => Place.fromJSON(e))).toList();
      }
    } on Exception {
      // nothing
    }
    _initialLoadIsDone = true;
  }
}
