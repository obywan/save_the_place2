import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../localization/localizations.dart';

import '../../bloc/places/places_bloc.dart';
import '../widgets/current_location_row.dart';
import '../widgets/places_list.dart';
import 'place_add_screen.dart';

class LocationsListScreen extends StatelessWidget {
  static const String route = '/places_list_screen';
  @override
  Widget build(BuildContext context) {
    final translations = CustomLocalizations.of(context);
    BlocProvider.of<PlacesBloc>(context, listen: false).add(GetPlaces());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(translations.pageTitles.homePageTitle),
        ),
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
          onPressed: () => Navigator.of(context).pushNamed(PlaceAddScreen.route),
        ),
      ),
    );
  }
}
