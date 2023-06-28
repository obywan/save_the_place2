import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'place_list_row.dart';

import '../../bloc/places/places_bloc.dart';
import '../../data/models/place.dart';
import '../../localization/localizations.dart';
import '../../localization/translations.i69n.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = CustomLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<PlacesBloc>(context, listen: false).add(GetPlaces());
      },
      child: BlocBuilder<PlacesBloc, PlacesState>(
        builder: (context, state) {
          if (state is PlacesLoading || state is PlacesAdded) return _getLoading();
          if (state is PlacesError) return _getErrorMessage(translations.messages.errorMessage);
          if (state is PlacesLoaded) {
            return _getList(context, state.places, translations);
          }
          return Center(
            child: Text(translations.general.noItemsInList),
          );
        },
      ),
    );
  }

  // Future<void> _refreshList(BuildContext context) {
  //   BlocProvider.of<PlacesBloc>(context, listen: false).add(GetPlaces());
  //   return Future(() => {});
  // }

  Widget _getList(BuildContext context, List<Place> places, Translations translations) {
    debugPrint('_getListCalled' + jsonEncode(places));
    if (places.length == 0)
      return Text(translations.general.noItemsInList);
    else
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, i) => PlaceListRow(
          place: places[i],
        ),
        itemCount: places.length,
      );
  }

  Widget _getLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getErrorMessage(String message) {
    return Center(child: Text(message));
  }
}
