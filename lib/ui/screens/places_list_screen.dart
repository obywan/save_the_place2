import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/places/places_bloc.dart';
import '../../data/models/place.dart';
import 'place_add_screen.dart';
import 'place_details_screen.dart';

class LocationsListScreen extends StatelessWidget {
  static const String route = '/places_list_screen';
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PlacesBloc>(context, listen: false).add(GetPlaces());
    return Scaffold(
      appBar: AppBar(
        title: Text('List of saved places'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshList(context),
        child: BlocBuilder<PlacesBloc, PlacesState>(
          builder: (context, state) {
            if (state is PlacesLoading || state is PlacesAdded) return _getLoading();
            if (state is PlacesError) return _getErrorMessage();
            if (state is PlacesLoaded) {
              return _getList(context, state.places);
            }
            return Center(
              child: Text('Locations list will be here'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(PlaceAddScreen.route),
      ),
    );
  }

  Future<void> _refreshList(BuildContext context) {
    BlocProvider.of<PlacesBloc>(context, listen: false).add(GetPlaces());
    return Future(() => {});
  }

  Widget _getList(BuildContext context, List<Place> places) {
    return ListView.builder(
      itemBuilder: (ctx, i) => Card(
        child: Dismissible(
          background: Container(color: Colors.red),
          key: ValueKey(places[i].location.latitude + places[i].location.longitude),
          child: ListTile(
            onTap: () => Navigator.of(context).pushNamed(PlaceDetailsScreen.route, arguments: places[i]),
            title: Text(places[i].name),
          ),
          onDismissed: (dir) => BlocProvider.of<PlacesBloc>(context, listen: false).add(RemovePlace(places[i])),
        ),
      ),
      itemCount: places.length,
    );
  }

  Widget _getLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getErrorMessage() {
    return Center(child: Text('Something went wrong'));
  }
}
