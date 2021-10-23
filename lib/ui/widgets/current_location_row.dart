import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:save_the_place/ui/widgets/spinny_thing.dart';

class CurrentLocationRow extends StatelessWidget {
  const CurrentLocationRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best, intervalDuration: Duration(seconds: 1));

    return StreamBuilder<Position>(
      stream: _positionStream,
      builder: (_, positionSnapshot) {
        if (positionSnapshot.connectionState == ConnectionState.active && positionSnapshot.data != null) {
          final coords = '${positionSnapshot.data?.latitude.toStringAsFixed(5)}, ${positionSnapshot.data?.longitude.toStringAsFixed(5)}';
          return _getContainer(context, coords, Colors.green.shade100);
        } else {
          return _getContainer(context, '', Colors.orange.shade100);
        }
      },
    );
  }

  Widget _getContainer(BuildContext context, String coordinates, Color color) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: coordinates));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('copied')));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: color,
        height: 64,
        child: coordinates.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'your location:',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        coordinates,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/svg/copy.svg',
                  )
                ],
              )
            : SpinnyThing(),
      ),
    );
  }
}
