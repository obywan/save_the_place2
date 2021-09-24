// import 'package:animated_rotation/animated_rotation.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';

class Compass extends StatefulWidget {
  final double bearing;

  const Compass({Key? key, required this.bearing}) : super(key: key);

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  Vector3 _accelerometer = Vector3.zero();

  Vector3 _magnetometer = Vector3.zero();

  Vector3 _absoluteOrientation2 = Vector3.zero();

  List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();

    subscriptions.add(motionSensors.accelerometer.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometer.setValues(event.x, event.y, event.z);
      });
    }));

    subscriptions.add(motionSensors.magnetometer.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometer.setValues(event.x, event.y, event.z);
        var matrix = motionSensors.getRotationMatrix(_accelerometer, _magnetometer);
        _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
      });
    }));
  }

  @override
  void dispose() {
    debugPrint('${subscriptions.length}');
    for (StreamSubscription s in subscriptions) s.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final north = _absoluteOrientation2.x / pi / 2;
    final target = (_absoluteOrientation2.x + widget.bearing) / pi / 2;
    // debugPrint('$north #### $target');
    return Stack(
      children: [
        Center(
          child: AnimatedRotation(
            turns: north,
            curve: Curves.ease,
            duration: Duration(seconds: 1),
            child: SvgPicture.asset('assets/svg/compass.svg'),
          ),
        ),
        Center(
          child: AnimatedRotation(
            turns: target,
            curve: Curves.ease,
            duration: Duration(seconds: 1),
            child: SvgPicture.asset('assets/svg/arrow.svg'),
          ),
        ),
      ],
    );
  }
}
