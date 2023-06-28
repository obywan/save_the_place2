import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
// import 'package:animated_rotation/animated_rotation.dart' as animR;

class Compass extends StatefulWidget {
  final double bearing;
  static const double twoPI = pi * 2;

  const Compass({Key? key, this.bearing = double.maxFinite}) : super(key: key);

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  Vector3 _accelerometer = Vector3.zero();

  Vector3 _magnetometer = Vector3.zero();

  Vector3 _absoluteOrientation2 = Vector3.zero();

  List<StreamSubscription> subscriptions = [];
  double oldDeviceOrientation = double.negativeInfinity;
  double newUIRotation = 0;

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

        //get normalized rotation (0-1 ragne)
        final preprocessedRotation = (_absoluteOrientation2.x > 0 ? _absoluteOrientation2.x : Compass.twoPI + _absoluteOrientation2.x) / Compass.twoPI;
        // debugPrint('$preprocessedRotation');

        //prepare placeholder to remember old rotation
        if (oldDeviceOrientation < -10000) {
          oldDeviceOrientation = preprocessedRotation;
          newUIRotation = preprocessedRotation;
          return;
        }

        //find out how much rotation has changed
        final delta = _getUIDelta(oldDeviceOrientation, preprocessedRotation);

        // final plusOne = newUIRotation + 1;

        newUIRotation -= delta;

        oldDeviceOrientation = preprocessedRotation;
      });
    }));
  }

  double _getUIDelta(double ol, double nw) {
    final plusOne = (ol - nw) + 1;
    final minusOne = (ol - nw) - 1;
    final none = ol - nw;

    if (none.abs() < plusOne.abs() && none.abs() < minusOne.abs()) {
      return none;
    }
    if (plusOne.abs() < none.abs() && plusOne.abs() < minusOne.abs()) {
      return plusOne;
    }
    if (minusOne.abs() < plusOne.abs() && minusOne.abs() < none.abs()) {
      return minusOne;
    }
    return 0;
  }

  @override
  void dispose() {
    // debugPrint('${subscriptions.length}');
    for (StreamSubscription s in subscriptions) s.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('$oldXRotation $northRotation');

    // final north = newUIRotation;

    // debugPrint('${widget.bearing}');

    final target = newUIRotation + (widget.bearing / 360);
    // debugPrint('$target');
    return Stack(
      children: [
        if (widget.bearing >= double.maxFinite) Align(alignment: Alignment.center, child: Text('Bearing ${_getRedableBearing()}')),
        Center(
          child: getAnimatedWidget(newUIRotation, 'assets/svg/compass_2.svg'),
        ),
        if (widget.bearing < double.maxFinite)
          Center(
            child: getAnimatedWidget(target, 'assets/svg/arrow.svg'),
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

  String _getRedableBearing() {
    final number = _absoluteOrientation2.x * 180 / pi;
    return (number >= 0 ? number : 360 + number).toStringAsFixed(0);
  }
}
