import 'package:evolabs/data/accelerometerData.dart';
import 'package:evolabs/charts/accel_gyro_chart.dart';
import 'package:evolabs/data/gyroscopeData.dart';
import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:evolabs/utils/file_io.dart' as file_io;

class AnalyzeSensors extends StatefulWidget {
  const AnalyzeSensors({Key? key}) : super(key: key);

  @override
  State<AnalyzeSensors> createState() => _AnalyzeSensorsState();
}

class _AnalyzeSensorsState extends State<AnalyzeSensors> {
  List<double>? _gyroscopeValues;
  List<double>? _userAccelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  final List<AccelerometerData> _accelerometerData = [];
  final List<GyroscopeData> _gyroscopeData = [];
  DateTime currentDateTime = DateTime.now();
  DateTime previousDateTime = DateTime.now();
  String mostRecentKeypress = "none";
  int keypressEventBuffer = 0;
  int previousTextBufferSize = 0;

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
                    return const Dashboard();
                  }));
                });
              },
            ),
          ),
        ),
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Analysis",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
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
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: TextField(
                cursorColor: highlightColor2,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.number,
                maxLines: 1,
                onChanged: (value) {
                  if (value.length > previousTextBufferSize) {
                    mostRecentKeypress = value
                        .substring((value.length - 1).clamp(0, value.length));
                  } else {
                    mostRecentKeypress = "backspace";
                  }
                  previousTextBufferSize = value.length;
                  keypressEventBuffer = 20;
                },
                decoration: const InputDecoration(
                  labelText: 'Start typing numbers here.',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
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
                                file_io.getFilePath("training");
                            if (await filePath != "ERROR") {
                              file_io.writeHeader(await filePath, "training");
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
                                  currentDateTime = DateTime.now();
                                  file_io.writeTrainingDataLine(
                                      mostRecentKeypress,
                                      await filePath,
                                      "${(((currentDateTime.hour - previousDateTime.hour) * 3.6e+9 + (currentDateTime.minute - previousDateTime.minute) * 6e+7 + (currentDateTime.second - currentDateTime.second) * 1e+6) - (currentDateTime.microsecond - previousDateTime.microsecond))}",
                                      _gyroscopeValues,
                                      _userAccelerometerValues);
                                  previousDateTime = currentDateTime;
                                  if (keypressEventBuffer > 0) {
                                    keypressEventBuffer--;
                                    if (keypressEventBuffer <= 0) {
                                      mostRecentKeypress = "none";
                                    }
                                  }
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
