// ignore: unused_import
import 'dart:async';
// ignore: unused_import
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:environment_sensors/environment_sensors.dart';
// ignore: unused_import
import 'package:fl_chart/fl_chart.dart';

class Barometer extends StatefulWidget {
  const Barometer({super.key});

  @override
  State<Barometer> createState() => _BarometerState();
}

class _BarometerState extends State<Barometer> {
  final environmentSensors = EnvironmentSensors();
  // ignore: prefer_final_fields, unused_field
  bool _pressureAvailable = false;

  @override
  Widget build(BuildContext context) {
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
          "Barometer",
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
          children: const [
            Text(
              "Real Time",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            // BAROMETER READING WILL GO HERE
          ],
        ),
      ),
    );
  }
}
