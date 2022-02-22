import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/place.dart';
import '../../data/repositories/firebase_places_repository.dart';
import '../../data/repositories/place_repository.dart';

part 'firebase_sync_event.dart';
part 'firebase_sync_state.dart';

class FirebaseSyncBloc extends Bloc<FirebaseSyncEvent, FirebaseSyncState> {
  final PlacesRepository _placesRepository;
  final FirebasePlacesRepository _firebasePlacesRepository;

  FirebaseSyncBloc(this._placesRepository, this._firebasePlacesRepository) : super(FirebaseSyncInitial()) {
    on<SyncPlaces>(_syncPlaces);
  }

  Future<void> _syncPlaces(SyncPlaces event, Emitter<FirebaseSyncState> emit) async {
    debugPrint('Sync places called');
    emit(FirebaseSyncProgress());

    List<Place> localPlaces = await _placesRepository.getPlaces();
    final List<Place> firebasePlaces = await _firebasePlacesRepository.getPlaces();

    debugPrint(localPlaces.length.toString());
    debugPrint(firebasePlaces.length.toString());
    for (Place fp in firebasePlaces) {
      if (localPlaces.where((element) => element.name == fp.name).length == 0) {
        debugPrint('${fp.name} was not on local dataset... Adding');
        await _placesRepository.addPlace(fp);
        localPlaces.add(fp);
      }
    }

    final data = jsonEncode(localPlaces);

    try {
      CollectionReference userPlaces = FirebaseFirestore.instance.collection('users_places');
      await userPlaces.doc(event.user.uid).set({'list': data}, SetOptions(merge: true));
    } on Exception {
      emit(FirebaseSyncError());
      return;
    }

    // FirebaseFirestore.instance.collection('userdata').doc(user.uid).set(data)
    emit(FirebaseSyncReady());
  }
}
