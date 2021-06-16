import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:save_the_place/data/models/place.dart';
import 'package:save_the_place/data/repositories/place_repository.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesResitory _placesRepository;

  PlacesBloc(this._placesRepository) : super(PlacesLoading());

  @override
  Stream<PlacesState> mapEventToState(
    PlacesEvent event,
  ) async* {
    if (event is GetPlaces) {
      yield PlacesLoading();
      try {
        final places = await _placesRepository.getPlaces();
        yield PlacesLoaded(places);
      } catch (e) {
        yield PlacesError(e.toString());
      }
    }
  }
}
