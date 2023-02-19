// ignore: unused_import
import 'package:evolabs/charts/accelerometerChart.dart';
// ignore: unused_import
import 'package:evolabs/data/accelerometerData.dart';
import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// ignore: unused_import
import 'package:sensors_plus/sensors_plus.dart';
import 'package:evolabs/utils/file_io.dart' as file_io;

class Keyboard extends StatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  List<double>? _userAccelerometerValues;
  int previousTextBufferSize = 0;
  Future<String>? filePath;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Keyboard",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 45),
            child: TextField(
              cursorColor: highlightColor2,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number,
              maxLines: 1,
              onChanged: (value) async {
                if (value.length > previousTextBufferSize) {
                  file_io.writeKeyboardDataLine(
                      await filePath,
                      DateTime.now(),
                      value.substring(
                          (value.length - 1).clamp(0, value.length)));
                } else {
                  file_io.writeKeyboardDataLine(
                      await filePath, DateTime.now(), "backspace");
                }
                previousTextBufferSize = value.length;
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
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
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
                    filePath = file_io.getFilePath("keyboard");
                    if (await filePath != "ERROR") {
                      file_io.writeHeader(await filePath, "keyboard");
                    } else {
                      // ignore: avoid_print
                      print("ERROR: Invalid File");
                    }
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
        ],
      ),
    );
  }
}
