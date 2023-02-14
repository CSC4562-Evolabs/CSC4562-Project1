// ignore_for_file: file_names

class AccelerometerData {
  final DateTime date;
  final List<double> value;

  AccelerometerData(this.date, this.value);

  DateTime get getDate => date;
  List<double> get getValue => value;
}
