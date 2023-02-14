import 'package:evolabs/screens/sensors/analyze_sensors.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Analyze extends StatefulWidget {
  const Analyze({super.key});

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  // BOOL VALUES FOR CHECKBOXES
  bool accelerometer = false;
  bool gyroscope = false;
  bool keyboard = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Scaffold(
          backgroundColor: backgroundColor2,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 120,
            backgroundColor: backgroundColor2,
            title: const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 78.0,
                  bottom: 15,
                ),
                child: Text(
                  "Analysis",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'Which sensors do you want to analyze?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                // ACCELEROMETER CHECKBOX
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  child: CheckboxListTile(
                    title: const Text(
                      'Accelerometer',
                    ),
                    subtitle: const Text(
                      'Measures the ammount of acceleration that acts upon your device.',
                    ),
                    activeColor: highlightColor2,
                    checkColor: primaryColor,
                    value: accelerometer,
                    onChanged: (bool? value) {
                      setState(() {
                        accelerometer = value!;
                      });
                    },
                  ),
                ),
                // GYROSCOPE CHECKBOX
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 25),
                  child: CheckboxListTile(
                    title: const Text(
                      'Gyroscope',
                    ),
                    subtitle: const Text(
                      'Measures the ammount of angular velocity that acts upon your device.',
                    ),
                    activeColor: highlightColor2,
                    checkColor: primaryColor,
                    value: gyroscope,
                    onChanged: (bool? value) {
                      setState(() {
                        gyroscope = value!;
                      });
                    },
                  ),
                ),
                // KEYBOARD CHECKBOX
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25),
                  child: CheckboxListTile(
                    title: const Text(
                      'Keyboard',
                    ),
                    subtitle: const Text(
                      'Detects the input that you want to give to your device.',
                    ),
                    activeColor: highlightColor2,
                    checkColor: primaryColor,
                    value: keyboard,
                    onChanged: (bool? value) {
                      setState(() {
                        keyboard = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: 225,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AnalyzeSensors(),
                              ),
                            );
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SvgPicture.asset('assets/images/green-circle1.svg'),
      ],
    );
  }
}
