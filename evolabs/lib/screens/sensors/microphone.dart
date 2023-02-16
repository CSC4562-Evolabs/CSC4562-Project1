import 'package:evolabs/screens/dashboard.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class Microphone extends StatefulWidget {
  const Microphone({Key? key}) : super(key: key);

  @override
  State<Microphone> createState() => _MicrophoneState();
}

class _MicrophoneState extends State<Microphone> {
  final recorder = FlutterSoundRecorder();

  // @override
  // void initState() {
  //   super.initState();

  //   initRecorder();
  // }

  // @override
  // void dispose() {
  //   recorder.closeRecorder();
  //   super.dispose();
  // }

  // Future initRecorder() async {
  //   final status = await Permission.microphone.request();

  //   if (status != PermissionStatus.granted) {
  //     throw 'Microphone permission has not been granted.';
  //   }
  //   await recorder.openRecorder();
  // }

  // Future record() async {
  //   await recorder.startRecorder(toFile: 'audio');
  // }

  // Future stop() async {
  //   await recorder.stopRecorder();
  // }

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
          "Microphone",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  shape: const CircleBorder(),
                ),
                onPressed: () async {
                  // if (recorder.isRecording) {
                  //   await stop();
                  // } else {
                  //   await record();
                  // }
                  // setState(() {});
                },
                child: Icon(
                  recorder.isRecording
                      ? Icons.stop_circle_outlined
                      : Icons.play_arrow_outlined,
                  size: 100,
                  color: highlightColor2,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
