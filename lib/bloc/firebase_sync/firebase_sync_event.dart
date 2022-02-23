part of 'firebase_sync_bloc.dart';

@immutable
abstract class FirebaseSyncEvent {}

class SyncPlaces extends FirebaseSyncEvent {
  final User user;

  SyncPlaces(this.user);
}

class WipeData extends FirebaseSyncEvent {
  final User user;

  WipeData(this.user);
}
