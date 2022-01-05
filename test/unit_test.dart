import 'package:flutter_test/flutter_test.dart';
import 'package:save_the_place/data/repositories/local_places_repository.dart';
import 'package:save_the_place/data/repositories/place_repository.dart';

void main() {
  test('Data not null', () async {
    final PlacesRepository placesRepo = LocalPlacesRepository();
    expect(await placesRepo.getPlaces(), isNotNull);
  });
}
