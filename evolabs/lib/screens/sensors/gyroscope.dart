import 'package:evolabs/charts/gyroscopeChart.dart';
import 'package:evolabs/data/gyroscopeData.dart';
import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class Gyroscope extends StatefulWidget {
  const Gyroscope({Key? key}) : super(key: key);

  @override
  State<Gyroscope> createState() => _GyroscopeState();
}

class _GyroscopeState extends State<Gyroscope> {
  List<double>? _gyroscopeValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  List<GyroscopeData> _gyroscopeData = [];

  @override
  Widget build(BuildContext context) {
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();

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
          "Gyroscope",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
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
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: 150,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: highlightColor4,
                          ),
                          onPressed: () {
                            _streamSubscriptions.add(
                              gyroscopeEvents.listen(
                                (GyroscopeEvent event) {
                                  _gyroscopeData.add(
                                    GyroscopeData(
                                      DateTime.now(),
                                      <double>[event.x, event.y, event.z],
                                    ),
                                  );
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ClipRRect(
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
                                builder: (context) => GyroscopeChart(
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
