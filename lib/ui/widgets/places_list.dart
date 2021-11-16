import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/places/places_bloc.dart';
import '../../data/models/place.dart';
import '../../localization/localizations.dart';
import '../screens/place_direction_screen.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = CustomLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: () => _refreshList(context),
      child: BlocBuilder<PlacesBloc, PlacesState>(
        builder: (context, state) {
          if (state is PlacesLoading || state is PlacesAdded) return _getLoading();
          if (state is PlacesError) return _getErrorMessage(translations.messages.errorMessage);
          if (state is PlacesLoaded) {
            return _getList(context, state.places);
          }
          return Center(
            child: Text(translations.general.noItemsInList),
          );
        },
      ),
    );
  }

  Future<void> _refreshList(BuildContext context) {
    BlocProvider.of<PlacesBloc>(context, listen: false).add(GetPlaces());
    return Future(() => {});
  }

  Widget _getList(BuildContext context, List<Place> places) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, i) => Card(
        child: Dismissible(
          background: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete),
              ],
            ),
          ),
          key: ValueKey(places[i].location.latitude + places[i].location.longitude),
          child: ListTile(
            onTap: () => Navigator.of(context).pushNamed(PlaceDirectionScreen.route, arguments: places[i]),
            title: Text(places[i].name),
          ),
          onDismissed: (dir) => BlocProvider.of<PlacesBloc>(context, listen: false).add(RemovePlace(places[i])),
          confirmDismiss: (dir) async {
            return await _confirmDelete(context);
          },
        ),
      ),
      itemCount: places.length,
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    final tr = CustomLocalizations.of(context);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(tr.dialogs.deleteTite),
            content: Text(tr.dialogs.areYouSureText),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(tr.dialogs.positiveAnswer)),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(tr.dialogs.negativeAnswer),
              ),
            ],
          );
        });
  }

  Widget _getLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getErrorMessage(String message) {
    return Center(child: Text(message));
  }
}
