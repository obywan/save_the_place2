import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/places/places_bloc.dart';
import '../../data/models/place.dart';
import '../../localization/localizations.dart';
import '../screens/place_direction_screen.dart';

class PlaceListRow extends StatelessWidget {
  final Place place;
  const PlaceListRow({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
        key: ValueKey(place.location.latitude + place.location.longitude),
        child: ListTile(
          onTap: () => Navigator.of(context).pushNamed(PlaceDirectionScreen.route, arguments: place),
          title: Text(place.name),
          subtitle: Row(
            children: [...(place.tags.map((e) => Chip(label: Text(e))).toList())],
          ),
        ),
        onDismissed: (dir) => BlocProvider.of<PlacesBloc>(context, listen: false).add(RemovePlace(place)),
        confirmDismiss: (dir) async {
          return await _confirmDelete(context);
        },
      ),
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
}
