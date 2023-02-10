import 'dart:io';
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

Future<String> getFilePath() async {
  String? saveDir;
  try {
    saveDir = await FilePicker.platform
        .getDirectoryPath(dialogTitle: "Save Results to: ");
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
  if (saveDir != null) {
    String filename =
        "${DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now())}.csv";
    return '$saveDir/$filename';
  } else {
    return "ERROR";
  }
}

void writeHeader(String savePath) {
  final file = File(savePath);
  file.writeAsStringSync("");
  file.writeAsStringSync(
      "# Timestamp,AccelerometerXvalue,AccelerometerYvalue,AccelerometerZvalue,GyroscopeXvalue,GyroscopeYvalue,GyroscopeZvalue [NEWLINE]\n",
      mode: FileMode.append);
}

void writeDataLine(String savePath, DateTime date,
    List<double>? gyroscopeValues, List<double>? accelerometerValues) {
  final file = File(savePath);
  if (gyroscopeValues != null && accelerometerValues != null) {
    file.writeAsStringSync(
        "$date,${accelerometerValues[0]},${accelerometerValues[1]},${accelerometerValues[2]},${gyroscopeValues[0]},${gyroscopeValues[1]},${gyroscopeValues[2]}\n",
        mode: FileMode.append);
  }
}
