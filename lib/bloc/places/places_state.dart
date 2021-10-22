part of 'places_bloc.dart';

@immutable
abstract class PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesInitial extends PlacesState {}

class PlacesAdded extends PlacesState {}

class PlacesRemoved extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Place> places;

  PlacesLoaded(this.places);
}

class PlacesError extends PlacesState {
  final String message;

  PlacesError(this.message);
}
