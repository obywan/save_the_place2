import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/place.dart';
import '../../data/repositories/place_repository.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesResitory _placesRepository;

  PlacesBloc(this._placesRepository) : super(PlacesInitial());

  @override
  Stream<PlacesState> mapEventToState(
    PlacesEvent event,
  ) async* {
    if (event is GetPlaces)
      yield* _onGetPlaces(event);
    else if (event is AddPlace) yield* _onAddPlace(event);
  }

  Stream<PlacesState> _onGetPlaces(PlacesEvent event) async* {
    yield PlacesLoading();
    try {
      final places = await _placesRepository.getPlaces();
      yield PlacesLoaded(places);
    } catch (e) {
      yield PlacesError(e.toString());
    }
  }

  Stream<PlacesState> _onAddPlace(PlacesEvent event) async* {
    yield PlacesLoading();
    try {
      final result =
          await _placesRepository.addPlace((event as AddPlace).place);
      if (!result)
        yield PlacesError('Adding place failed');
      else {
        yield PlacesAdded();
        final places = await _placesRepository.getPlaces();
        yield PlacesLoaded(places);
      }
    } catch (e) {
      yield PlacesError(e.toString());
    }
  }
}
