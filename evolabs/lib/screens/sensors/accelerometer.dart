import 'package:evolabs/charts/accelerometerChart.dart';
import 'package:evolabs/data/accelerometerData.dart';
import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:evolabs/utils/file_io.dart' as file_io;

class Accelerometer extends StatefulWidget {
  const Accelerometer({Key? key}) : super(key: key);

  @override
  State<Accelerometer> createState() => _AccelerometerState();
}

class _AccelerometerState extends State<Accelerometer> {
  List<double>? _userAccelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  final List<AccelerometerData> _accelerometerData = [];

  @override
  Widget build(BuildContext context) {
    final userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
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
        title: const Text(
          "Accelerometer",
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
              "Real Time",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
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
                                file_io.getFilePath("accel");
                            if (await filePath != "ERROR") {
                              file_io.writeHeader(await filePath, "accel");
                            } else {
                              // ignore: avoid_print
                              print("ERROR: Invalid File");
                            }
                            _streamSubscriptions.add(
                              accelerometerEvents.listen(
                                (AccelerometerEvent event) async {
                                  _accelerometerData.add(
                                    AccelerometerData(
                                      DateTime.now(),
                                      <double>[event.x, event.y, event.z],
                                    ),
                                  );
                                  file_io.writeAccelDataLine(await filePath,
                                      DateTime.now(), _userAccelerometerValues);
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
                              builder: (context) => AccelerometerChart(
                                  accelerometerData: _accelerometerData),
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
                  ),
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
  }
}
