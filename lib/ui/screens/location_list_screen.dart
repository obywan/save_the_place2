import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_the_place/ui/screens/location_add_screen.dart';
import '../../data/models/place.dart';

import '../../bloc/bloc/places_bloc.dart';

class LocationsListScreen extends StatelessWidget {
  static const String route = '/location_list_screen';
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
            if (state is PlacesLoading || state is PlacesAdded)
              return _getLoading();
            if (state is PlacesError) return _getErrorMessage();
            if (state is PlacesLoaded) {
              return _getList(state.places);
            }
            return Center(
              child: Text('Locations list will be here'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(LocationAddScreen.route),
      ),
    );
  }

  Future<void> _refreshList(BuildContext context) {
    BlocProvider.of<PlacesBloc>(context, listen: false).add(GetPlaces());
    return Future(() => {});
  }

  Widget _getList(List<Place> places) {
    return ListView.builder(
      itemBuilder: (ctx, i) => Card(
        child: ListTile(
          title: Text(places[i].name),
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
