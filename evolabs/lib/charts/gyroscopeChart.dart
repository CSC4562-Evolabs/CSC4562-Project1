import 'package:flutter/material.dart';
import 'package:evolabs/utils/colors.dart';
import 'package:evolabs/data/gyroscopeData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:evolabs/screens/sensors/gyroscope.dart';

class GyroscopeChart extends StatefulWidget {
  const GyroscopeChart({Key? key, required this.gyroscopeData})
      : super(key: key);
  final List<GyroscopeData> gyroscopeData;

  @override
  State<GyroscopeChart> createState() => _GyroscopeChartState();
}

class _GyroscopeChartState extends State<GyroscopeChart> {
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
                    return const Gyroscope();
                  }));
                });
              },
            ),
          ),
        ),
        title: const Text(
          "Results",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
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
    );
  }
}
