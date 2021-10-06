import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:motion_sensors/motion_sensors.dart';
// import 'package:animated_rotation/animated_rotation.dart' as animR;

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
  double oldXRotation = 0;
  double northRotation = 0;

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

        final preprocessedRotation = _absoluteOrientation2.x > 0 ? _absoluteOrientation2.x : 6.28 + _absoluteOrientation2.x;
        final lineCrossed = (oldXRotation - preprocessedRotation).abs() > 6;

        if (!lineCrossed)
          northRotation += preprocessedRotation - oldXRotation;
        else if (_absoluteOrientation2.x < 0)
          northRotation += oldXRotation + 6.28 - preprocessedRotation;
        else
          northRotation += preprocessedRotation + 6.28 - oldXRotation;

        oldXRotation = preprocessedRotation;
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
    final north = northRotation;
    final target = north + widget.bearing / (180 / pi);
    // debugPrint('$north');
    return Stack(
      children: [
        Center(
          child: getAnimatedWidget(north / pi / 2, 'assets/svg/compass.svg'),
        ),
        Center(
          child: getAnimatedWidget(target / pi / 2, 'assets/svg/arrow.svg'),
        ),
      ],
    );
  }

  AnimatedRotation getAnimatedWidget(double turns, String image) {
    return AnimatedRotation(
      turns: turns,
      curve: Curves.ease,
      duration: Duration(milliseconds: 300),
      child: SvgPicture.asset(image),
    );
  }

  Widget getPlainWidget(double angle, String image) {
    return Transform.rotate(
      angle: angle,
      child: SvgPicture.asset(image),
    );
  }
}
