import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_place/data/repositories/place_repository.dart';

class FirebaseSyncHelper {
  final PlacesRepository placesRepository;

  FirebaseSyncHelper(this.placesRepository);

  Future<bool> sync() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final data = jsonEncode(await placesRepository.getPlaces());
    debugPrint(data);
    // FirebaseFirestore.instance.collection('userdata').doc(user.uid).set(data)
    return true;
  }

  Future<bool> grabData() async {
    return true;
  }

  Future<bool> postData() async {
    return true;
  }
}
