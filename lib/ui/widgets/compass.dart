import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    motionSensors.accelerometer.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometer.setValues(event.x, event.y, event.z);
      });
    });

    motionSensors.magnetometer.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometer.setValues(event.x, event.y, event.z);
        var matrix = motionSensors.getRotationMatrix(_accelerometer, _magnetometer);
        _absoluteOrientation2.setFrom(motionSensors.getOrientation(matrix));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('${degrees(_absoluteOrientation2.x).toStringAsFixed(4)}'),
    );
  }
}
