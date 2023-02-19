import 'dart:io';
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

Future<String> getFilePath(String dataType) async {
  String? saveDir;
  try {
    saveDir = await FilePicker.platform
        .getDirectoryPath(dialogTitle: "Save Results to: ");
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
  String filename =
      "${DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now())}-error.csv";
  if (saveDir != null) {
    switch (dataType) {
      case "training":
        {
          filename =
              "${DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now())}.csv";
          break;
        }
      case "motion":
        {
          filename =
              "${DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now())}-motion.csv";
          break;
        }
      case "accel":
        {
          filename =
              "${DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now())}-accel.csv";
          break;
        }
      case "gyro":
        {
          filename =
              "${DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now())}-gyro.csv";
          break;
        }
      case "keyboard":
        {
          filename =
              "${DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now())}-keyboard.csv";
          break;
        }
    }
    return '$saveDir/$filename';
  } else {
    return "ERROR";
  }
}

void writeHeader(String? savePath, String dataType) {
  final file = File(savePath as String);
  file.writeAsStringSync("");
  switch (dataType) {
    case "training":
      {
        file.writeAsStringSync(
            "# Timestamp,MostRecentKeypress,AccelerometerXvalue,AccelerometerYvalue,AccelerometerZvalue,GyroscopeXvalue,GyroscopeYvalue,GyroscopeZvalue [NEWLINE]\n",
            mode: FileMode.append);
        break;
      }
    case "motion":
      {
        file.writeAsStringSync(
            "# Timestamp,AccelerometerXvalue,AccelerometerYvalue,AccelerometerZvalue,GyroscopeXvalue,GyroscopeYvalue,GyroscopeZvalue [NEWLINE]\n",
            mode: FileMode.append);
        break;
      }
    case "accel":
      {
        file.writeAsStringSync(
            "# Timestamp,AccelerometerXvalue,AccelerometerYvalue,AccelerometerZvalue [NEWLINE]\n",
            mode: FileMode.append);
        break;
      }
    case "gyro":
      {
        file.writeAsStringSync(
            "# Timestamp,GyroscopeXvalue,GyroscopeYvalue,GyroscopeZvalue [NEWLINE]\n",
            mode: FileMode.append);
        break;
      }
    case "keyboard":
      {
        file.writeAsStringSync("# Timestamp,MostRecentKeypress [NEWLINE]\n",
            mode: FileMode.append);
        break;
      }
  }
}

void writeTrainingDataLine(
    String mostRecentKeypress,
    String savePath,
    DateTime date,
    List<double>? gyroscopeValues,
    List<double>? accelerometerValues) {
  final file = File(savePath);
  if (gyroscopeValues != null && accelerometerValues != null) {
    file.writeAsStringSync(
        "$date,$mostRecentKeypress,${accelerometerValues[0]},${accelerometerValues[1]},${accelerometerValues[2]},${gyroscopeValues[0]},${gyroscopeValues[1]},${gyroscopeValues[2]}\n",
        mode: FileMode.append);
  }
}

void writeMotionDataLine(String savePath, DateTime date,
    List<double>? gyroscopeValues, List<double>? accelerometerValues) {
  final file = File(savePath);
  if (gyroscopeValues != null && accelerometerValues != null) {
    file.writeAsStringSync(
        "$date,${accelerometerValues[0]},${accelerometerValues[1]},${accelerometerValues[2]},${gyroscopeValues[0]},${gyroscopeValues[1]},${gyroscopeValues[2]}\n",
        mode: FileMode.append);
  }
}

void writeGyroDataLine(
    String savePath, DateTime date, List<double>? gyroscopeValues) {
  final file = File(savePath);
  if (gyroscopeValues != null) {
    file.writeAsStringSync(
        "$date,${gyroscopeValues[0]},${gyroscopeValues[1]},${gyroscopeValues[2]}\n",
        mode: FileMode.append);
  }
}

void writeAccelDataLine(
    String savePath, DateTime date, List<double>? accelerometerValues) {
  final file = File(savePath);
  if (accelerometerValues != null) {
    file.writeAsStringSync(
        "$date,${accelerometerValues[0]},${accelerometerValues[1]},${accelerometerValues[2]}\n",
        mode: FileMode.append);
  }
}

void writeKeyboardDataLine(String? savePath, DateTime date, String keypress) {
  if (savePath != null) {
    final file = File(savePath);
    file.writeAsStringSync("$date,$keypress\n", mode: FileMode.append);
  }
}
