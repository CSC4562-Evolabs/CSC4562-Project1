import 'package:evolabs/data/accelerometerData.dart';
import 'package:evolabs/charts/accel_gyro_chart.dart';
import 'package:evolabs/data/gyroscopeData.dart';
import 'package:evolabs/screens/analyze.dart';
// ignore: unused_import
import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:evolabs/utils/file_io.dart' as file_io;

class AccelGyro extends StatefulWidget {
  const AccelGyro({Key? key}) : super(key: key);

  @override
  State<AccelGyro> createState() => _AccelGyroState();
}

class _AccelGyroState extends State<AccelGyro> {
  List<double>? _gyroscopeValues;
  List<double>? _userAccelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  final List<AccelerometerData> _accelerometerData = [];
  final List<GyroscopeData> _gyroscopeData = [];

  @override
  Widget build(BuildContext context) {
    final userAccelerometer = _userAccelerometerValues
        ?.map((double accelV) => accelV.toStringAsFixed(1))
        .toList();
    final gyroscope = _gyroscopeValues
        ?.map((double gyroV) => gyroV.toStringAsFixed(1))
        .toList();

    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 120,
        backgroundColor: backgroundColor2,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Ink(
            decoration: const ShapeDecoration(
              color: backgroundColor,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: highlightColor2,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, MaterialPageRoute(builder: (context) {
                    return const Analyze();
                  }));
                });
              },
            ),
          ),
        ),
        title: const Text(
          "Accelerometer and Gyroscope data",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // REAL TIME ACCEL DATA
      body: Padding(
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Accelerometer:",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'X , Y , Z  :  $userAccelerometer',
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Gyroscope:",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'X , Y , Z  :  $gyroscope',
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 135),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: 150,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: highlightColor4,
                          ),
                          onPressed: () async {
                            Future<String> filePath =
                                file_io.getFilePath("motion");
                            if (await filePath != "ERROR") {
                              file_io.writeHeader(await filePath, "motion");
                            } else {
                              // ignore: avoid_print
                              print("ERROR: Invalid File");
                            }
                            _streamSubscriptions.add(
                              accelerometerEvents.listen(
                                (AccelerometerEvent event) {
                                  _accelerometerData.add(
                                    AccelerometerData(
                                      DateTime.now(),
                                      <double>[event.x, event.y, event.z],
                                    ),
                                  );
                                },
                              ),
                            );
                            _streamSubscriptions.add(
                              gyroscopeEvents.listen(
                                (GyroscopeEvent event) async {
                                  _gyroscopeData.add(
                                    GyroscopeData(
                                      DateTime.now(),
                                      <double>[event.x, event.y, event.z],
                                    ),
                                  );
                                  file_io.writeMotionDataLine(
                                      await filePath,
                                      DateTime.now(),
                                      _gyroscopeValues,
                                      _userAccelerometerValues);
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Start",
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: 150,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccelGyroChart(
                                  accelerometerData: _accelerometerData,
                                  gyroscopeData: _gyroscopeData),
                            ),
                          );
                        },
                        child: const Text(
                          "Stop",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                              color: primaryColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}
