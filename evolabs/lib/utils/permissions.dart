import 'package:evolabs/screens/settings.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions extends StatefulWidget {
  const Permissions({super.key});

  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
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
                    return const Settings();
                  }));
                });
              },
            ),
          ),
        ),
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Permissions",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // MICROPHONE PERMISSIONS
          ListTile(
            title: const Text("Microphone"),
            subtitle: const Text("Status of Permission:"),
            leading: const CircleAvatar(
              child: Icon(Icons.mic),
            ),
            trailing: const Icon(
              Icons.check_circle,
              color: highlightColor2,
            ),
            onTap: () async {
              PermissionStatus microphoneStatus =
                  await Permission.microphone.request();
              if (microphoneStatus == PermissionStatus.granted) {}
              if (microphoneStatus == PermissionStatus.denied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Padding(
                      padding: EdgeInsets.only(bottom: 75),
                      child: Text(
                        "EvoLabs needs to access your microphone to detect vibrations.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (microphoneStatus == PermissionStatus.permanentlyDenied) {
                openAppSettings();
              }
            },
          ),
          // SENSOR PERMISSIONS
          ListTile(
            title: const Text("Sensors"),
            subtitle: const Text("Status of Permission:"),
            leading: const CircleAvatar(
              child: Icon(Icons.sensors),
            ),
            trailing: const Icon(
              Icons.check_circle,
              color: highlightColor2,
            ),
            onTap: () async {
              PermissionStatus sensorStatus =
                  await Permission.sensors.request();
              if (sensorStatus == PermissionStatus.granted) {}
              if (sensorStatus == PermissionStatus.denied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Padding(
                      padding: EdgeInsets.only(bottom: 75),
                      child: Text(
                        "EvoLabs needs to access the motion sensors on your device to be able to display the Accelerometer and Gyroscope data.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (sensorStatus == PermissionStatus.permanentlyDenied) {
                openAppSettings();
              }
            },
          ),
          // LOCATION PERMISSIONS
          ListTile(
            title: const Text("Location"),
            subtitle: const Text("Status of Permission:"),
            leading: const CircleAvatar(
              child: Icon(Icons.pin_drop_outlined),
            ),
            trailing: const Icon(
              Icons.check_circle,
              color: highlightColor2,
            ),
            onTap: () async {
              PermissionStatus locationStatus =
                  await Permission.locationWhenInUse.request();
              if (locationStatus == PermissionStatus.granted) {}
              if (locationStatus == PermissionStatus.denied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Padding(
                      padding: EdgeInsets.only(bottom: 75),
                      child: Text(
                        "EvoLabs needs to access your Locations Services to access GPS data.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (locationStatus == PermissionStatus.permanentlyDenied) {
                openAppSettings();
              }
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: 300,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                    ),
                    onPressed: (requestPermissionWithOpenSettings),
                    child: const Text(
                      "Open Settings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        color: primaryColor,
                      ),
                    ),
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

void requestPermissionWithOpenSettings() async {
  openAppSettings();
}
