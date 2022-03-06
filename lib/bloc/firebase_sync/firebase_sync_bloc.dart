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
    on<WipeData>(_wipeData);
  }

  Future<void> _syncPlaces(SyncPlaces event, Emitter<FirebaseSyncState> emit) async {
    debugPrint('Sync places called');
    emit(FirebaseSyncProgress());

    List<Place> localPlaces = await _placesRepository.getPlaces();
    final List<Place> firebasePlaces = await _firebasePlacesRepository.getPlaces();

    for (Place fp in firebasePlaces) {
      if (!localPlaces.contains(fp)) {
        debugPrint('${fp.name} was not on local dataset... Adding');
        await _placesRepository.addPlace(fp);
        localPlaces.add(fp);
      }
    }

    final data = jsonEncode(localPlaces);

    try {
      CollectionReference userPlaces = FirebaseFirestore.instance.collection(FirebasePlacesRepository.user_places_collection);
      await userPlaces.doc(event.user.uid).set({'list': data}, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      emit(FirebaseSyncError(message: e.message ?? ''));
      return;
    }

    emit(FirebaseSyncReady());
  }

  Future<void> _wipeData(WipeData event, Emitter<FirebaseSyncState> emit) async {
    debugPrint('Sync places called');
    emit(FirebaseSyncProgress());
    try {
      CollectionReference userPlaces = FirebaseFirestore.instance.collection(FirebasePlacesRepository.user_places_collection);
      await userPlaces.doc(event.user.uid).delete();
      await event.user.delete();
    } on FirebaseException catch (e) {
      emit(FirebaseSyncError(message: e.message == null ? '' : e.message!.replaceAll('. ', '.\n')));
      return;
    }
    emit(FirebaseSyncReady());
  }
}
