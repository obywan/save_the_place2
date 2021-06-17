part of 'places_bloc.dart';

@immutable
abstract class PlacesEvent {}

class GetPlaces extends PlacesEvent {}

class AddPlace extends PlacesEvent {
  final Place place;

  AddPlace(this.place);
}
