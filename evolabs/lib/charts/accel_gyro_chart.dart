import 'package:flutter/material.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:evolabs/data/accelerometerData.dart';
import 'package:evolabs/data/gyroscopeData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:evolabs/screens/sensors/accelerometer.dart';

class AccelGyroChart extends StatefulWidget {
  const AccelGyroChart(
      {Key? key, required this.accelerometerData, required this.gyroscopeData})
      : super(key: key);
  final List<AccelerometerData> accelerometerData;
  final List<GyroscopeData> gyroscopeData;

  @override
  State<AccelGyroChart> createState() => _AccelGyroChartState();
}

class _AccelGyroChartState extends State<AccelGyroChart> {
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
                    return const Accelerometer();
                  }));
                });
              },
            ),
          ),
        ),
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Results",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 60),
          child: Column(
            children: [
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                  text: 'Accelerometer',
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                  ),
                ),
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                ),
                enableAxisAnimation: true,
                series: <ChartSeries<AccelerometerData, DateTime>>[
                  LineSeries<AccelerometerData, DateTime>(
                    dataSource: widget.accelerometerData,
                    xValueMapper: (AccelerometerData value, _) => value.getDate,
                    yValueMapper: (AccelerometerData value, _) =>
                        value.getValue[0],
                    name: 'X',
                    color: highlightColor2,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 3,
                      borderColor: highlightColor2,
                    ),
                  ),
                  LineSeries<AccelerometerData, DateTime>(
                    dataSource: widget.accelerometerData,
                    xValueMapper: (AccelerometerData value, _) => value.getDate,
                    yValueMapper: (AccelerometerData value, _) =>
                        value.getValue[1],
                    name: 'Y',
                    color: highlightColor1,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 3,
                      borderColor: highlightColor1,
                    ),
                  ),
                  LineSeries<AccelerometerData, DateTime>(
                    dataSource: widget.accelerometerData,
                    xValueMapper: (AccelerometerData value, _) => value.getDate,
                    yValueMapper: (AccelerometerData value, _) =>
                        value.getValue[2],
                    name: 'Z',
                    color: primaryColor,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 3,
                      borderColor: secondaryColor,
                    ),
                  ),
                ],
              ),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                  text: 'Gyroscope',
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                  ),
                ),
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                ),
                enableAxisAnimation: true,
                series: <ChartSeries<GyroscopeData, DateTime>>[
                  LineSeries<GyroscopeData, DateTime>(
                    dataSource: widget.gyroscopeData,
                    xValueMapper: (GyroscopeData value, _) => value.getDate,
                    yValueMapper: (GyroscopeData value, _) => value.getValue[0],
                    name: 'X',
                    color: highlightColor2,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 3,
                      borderColor: highlightColor2,
                    ),
                  ),
                  LineSeries<GyroscopeData, DateTime>(
                    dataSource: widget.gyroscopeData,
                    xValueMapper: (GyroscopeData value, _) => value.getDate,
                    yValueMapper: (GyroscopeData value, _) => value.getValue[1],
                    name: 'Y',
                    color: highlightColor1,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 3,
                      borderColor: highlightColor1,
                    ),
                  ),
                  LineSeries<GyroscopeData, DateTime>(
                    dataSource: widget.gyroscopeData,
                    xValueMapper: (GyroscopeData value, _) => value.getDate,
                    yValueMapper: (GyroscopeData value, _) => value.getValue[2],
                    name: 'Z',
                    color: primaryColor,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 3,
                      borderColor: secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
