import 'package:flutter/material.dart';
import 'package:save_the_place/data/models/place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String route = '/place_details_screen';
  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
    );
  }
}
