import 'package:evolabs/screens/sensors/accel_gyro.dart';
import 'package:evolabs/screens/sensors/barometer.dart';
import 'package:evolabs/screens/sensors/gyroscope.dart';
import 'package:evolabs/screens/sensors/keyboard.dart';
import 'package:evolabs/screens/sensors/microphone.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evolabs/screens/sensors/accelerometer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                  "Welcome",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25, top: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Sensors",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 35,
                        mainAxisSpacing: 45,
                        padding: const EdgeInsets.only(
                          top: 35,
                          bottom: 60,
                          left: 35,
                          right: 35,
                        ),
                        children: [
                          // ACCELEROMETER TILE
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Accelerometer();
                                }));
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Accelerometer",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/accelerometer.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // BAROMETER TILE
                          OutlinedButton(
                            onPressed: () {
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const Barometer();
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Barometer",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/barometer.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // COMPASS TILE
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Compass",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/compass.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // GPS TILE
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "GPS",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/pin-outline.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // GYROSCOPE TILE
                          OutlinedButton(
                            onPressed: () {
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const Gyroscope();
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Gyroscope",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/gyroscope.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // HUMIDITY TILE
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Humidity",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/humidity.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // KEYBOARD SENSOR
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Keyboard();
                                }));
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  "Keyboard",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  child: Icon(
                                    Icons.keyboard_alt_outlined,
                                    size: 75,
                                    color: Color.fromARGB(255, 118, 118, 118),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // LIGHT TILE
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Light",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/sun.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // LIDAR TILE
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "LIDAR",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/lidar.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // MOTION SENSORS
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AccelGyro();
                                }));
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  "Motion",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  child: Icon(
                                    Icons.sensors_sharp,
                                    size: 75,
                                    color: Color.fromARGB(255, 118, 118, 118),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // MICROPHONE
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Microphone();
                                }));
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  "Microphone",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  child: Icon(
                                    Icons.mic_outlined,
                                    size: 75,
                                    color: Color.fromARGB(255, 118, 118, 118),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // TEMPERATURE TILE
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              side: MaterialStateProperty.all(BorderSide.none),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Temperature",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/thermometer.svg',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SvgPicture.asset('assets/images/green-circle1.svg'),
      ],
    );
  }
}
