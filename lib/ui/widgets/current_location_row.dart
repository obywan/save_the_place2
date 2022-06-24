import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../../localization/localizations.dart';
import 'spinny_thing.dart';

class CurrentLocationRow extends StatelessWidget {
  const CurrentLocationRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _positionStream = Geolocator.getPositionStream();

    return StreamBuilder<Position>(
      stream: _positionStream,
      builder: (_, positionSnapshot) {
        if (positionSnapshot.connectionState == ConnectionState.active && positionSnapshot.data != null) {
          // debugPrint(positionSnapshot.data.accuracy);
          final coords = '${positionSnapshot.data!.latitude.toStringAsFixed(5)}, ${positionSnapshot.data!.longitude.toStringAsFixed(5)}';
          return _getContainer(context, coords, positionSnapshot.data?.accuracy, Colors.green.shade100);
        } else {
          return _getContainer(context, '', 0, Colors.orange.shade100);
        }
      },
    );
  }

  Widget _getContainer(BuildContext context, String coordinates, double? accuracy, Color color) {
    final translations = CustomLocalizations.of(context);
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: coordinates));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(translations.messages.copied)));
      },
      child: Card(
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 64,
          child: coordinates.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                    ),
                    SizedBox(width: 16),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       translations.general.currentLocation,
                    //       style: TextStyle(fontSize: 10, color: Colors.grey),
                    //     ),
                    Text(
                      '$coordinates (acc: ${accuracy?.toStringAsFixed(0)}m)',
                      style: TextStyle(fontSize: 16),
                    ),
                    //   ],
                    // ),
                    Spacer(),
                    Icon(Icons.copy)
                  ],
                )
              : SpinnyThing(),
        ),
      ),
    );
  }
}
