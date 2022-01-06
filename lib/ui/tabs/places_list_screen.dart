import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/places/places_bloc.dart';
import '../widgets/current_location_row.dart';
import '../widgets/places_list.dart';
import '../screens/place_add_screen.dart';

class LocationsListScreen extends StatelessWidget {
  static const String route = '/places_list_screen';

  void _onFABPewssed(BuildContext context) {
    Navigator.of(context).pushNamed(PlaceAddScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PlacesBloc>(context, listen: false).add(GetPlaces());
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CurrentLocationRow(),
          Divider(),
          Expanded(
            child: PlacesList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => _onFABPewssed(context),
      ),
    );
  }
}
