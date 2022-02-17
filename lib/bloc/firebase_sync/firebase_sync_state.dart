part of 'firebase_sync_bloc.dart';

@immutable
abstract class FirebaseSyncState {}

class FirebaseSyncInitial extends FirebaseSyncState {}

class FirebaseSyncProgress extends FirebaseSyncState {}

class FirebaseSyncReady extends FirebaseSyncState {}

class FirebaseSyncError extends FirebaseSyncState {}
