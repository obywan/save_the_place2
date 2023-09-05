import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/place.dart';
import 'place_repository.dart';

class FirebasePlacesRepository extends PlacesRepository {
  static const String user_places_collection = 'users_places';
  @override
  Future<bool> addPlace(Place p) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    final currentList = await getPlaces();
    final data = jsonEncode([...currentList, p]);
    try {
      CollectionReference userPlaces = FirebaseFirestore.instance.collection(user_places_collection);
      await userPlaces.doc(user.uid).set({'list': data}, SetOptions(merge: true));
      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<List<Place>> getPlaces() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    try {
      debugPrint('Obtaining firebase places');
      final documentSnapshot = await FirebaseFirestore.instance.collection(user_places_collection).doc(user.uid).get();
      if (documentSnapshot.data() == null) return [];
      final Iterable json = jsonDecode(documentSnapshot.data()!['list']);
      final List<Place> places = List<Place>.from((json).map((e) => Place.fromJSON(e)));
      return places;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<bool> removePlace(Place p) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    final cloudSavedPlaces = await getPlaces();
    if (cloudSavedPlaces.contains(p)) {
      debugPrint('we have found this place in cloud!');
      cloudSavedPlaces.remove(p);
    }
    final data = jsonEncode(cloudSavedPlaces);

    try {
      CollectionReference userPlaces = FirebaseFirestore.instance.collection(user_places_collection);
      await userPlaces.doc(user.uid).set({'list': data}, SetOptions(merge: false));
      return true;
    } on Exception {
      return false;
    }
  }

  // @override
  // Set<String> getTags() {
  //   return {};
  // }
}
