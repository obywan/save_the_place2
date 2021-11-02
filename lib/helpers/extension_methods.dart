import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../data/models/place.dart';

extension PlaceBearing on Position {
  double getBearing(Place p) {
    return Geolocator.bearingBetween(this.latitude, this.longitude, p.location.latitude, p.location.longitude);
  }
}

extension Distance on double {
  String getReadableDistance() {
    if (this > 1000) {
      return '${this ~/ 1000}km ${(this % 1000).toInt()}m';
    } else
      return '${this.toInt()}m';
  }
}

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}
