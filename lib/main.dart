import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_the_place/ui/screens/location_add_screen.dart';

import 'bloc/bloc/places_bloc.dart';
import 'data/repositories/place_repository.dart';
import 'ui/screens/location_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaveThePlace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            PlacesBloc(FakePlaceRepository())..add(GetPlaces()),
        child: LocationsListScreen(),
      ),
      routes: {
        LocationsListScreen.route: (context) => LocationsListScreen(),
        LocationAddScreen.route: (context) => LocationAddScreen(),
      },
    );
  }
}
