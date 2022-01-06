import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/place.dart';
import '../../data/repositories/place_repository.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlacesRepository _placesRepository;

  PlacesBloc(this._placesRepository) : super(PlacesInitial()) {
    on<GetPlaces>(_onGetPlaces);
    on<AddPlace>(_onAddPlace);
    on<RemovePlace>(_onRemovePlace);
  }

  Future<void> _onGetPlaces(GetPlaces event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    try {
      final places = await _placesRepository.getPlaces();
      emit(PlacesLoaded(places));
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }

  Future<void> _onAddPlace(AddPlace event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    try {
      final result = await _placesRepository.addPlace((event).place);
      if (!result)
        emit(PlacesError('Adding place failed'));
      else {
        emit(PlacesAdded());
        final places = await _placesRepository.getPlaces();
        emit(PlacesLoaded(places));
      }
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }

  Future<void> _onRemovePlace(RemovePlace event, Emitter<PlacesState> emit) async {
    emit(PlacesLoading());
    try {
      final result = await _placesRepository.removePlace((event).place);
      if (!result)
        emit(PlacesError('Removing place failed'));
      else {
        emit(PlacesRemoved());
        final places = await _placesRepository.getPlaces();
        emit(PlacesLoaded(places));
      }
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }
}
