import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/place_repository.dart';

part 'firebase_sync_event.dart';
part 'firebase_sync_state.dart';

class FirebaseSyncBloc extends Bloc<FirebaseSyncEvent, FirebaseSyncState> {
  final PlacesRepository _placesRepository;

  FirebaseSyncBloc(this._placesRepository) : super(FirebaseSyncInitial()) {
    on<FirebaseSyncEvent>((event, emit) {
      on<SyncPlaces>(_syncPlaces);
    });
  }

  Future<void> _syncPlaces(SyncPlaces event, Emitter<FirebaseSyncState> emit) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(FirebaseSyncError());
      return;
    }
    emit(FirebaseSyncProgress());
    final data = jsonEncode(await _placesRepository.getPlaces());

    CollectionReference userPlaces = FirebaseFirestore.instance.collection('users_places');

    try {
      await userPlaces.doc(user.uid).set({'list': data}, SetOptions(merge: true));
    } on Exception {
      emit(FirebaseSyncError());
      return;
    }

    // FirebaseFirestore.instance.collection('userdata').doc(user.uid).set(data)
    emit(FirebaseSyncReady());
  }
}
