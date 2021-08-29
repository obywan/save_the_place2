import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/places/places_bloc.dart';
import 'data/repositories/place_repository.dart';
import 'ui/screens/place_add_screen.dart';
import 'ui/screens/place_details_screen.dart';
import 'ui/screens/places_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlacesBloc>(create: (context) => PlacesBloc(FakePlaceRepository())),
      ],
      child: MaterialApp(
        title: 'SaveThePlace',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LocationsListScreen(),
        routes: {
          LocationsListScreen.route: (context) => LocationsListScreen(),
          PlaceAddScreen.route: (context) => PlaceAddScreen(),
          PlaceDetailsScreen.route: (context) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
