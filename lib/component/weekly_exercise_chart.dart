import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/controllers/weekly_chart_controller.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyExerciseChart extends StatefulWidget {
  const WeeklyExerciseChart({Key? key}) : super(key: key);

  @override
  State<WeeklyExerciseChart> createState() => _WeeklyExerciseChartState();
}

class _WeeklyExerciseChartState extends State<WeeklyExerciseChart> {
  final AuthController _controller = Get.put(AuthController());
  late String uid;

  @override
  void initState() {
    uid = _controller.getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<WeeklyChartController>(
        init: WeeklyChartController(userId: uid),
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2,
                ),
              ],
            ),
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'This week, You finished',
                style: TextStyle(
                    fontSize: 22,
                    color: hexStringToColor('3A476C'),
                    fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Text(
                  'Total : ${controller.total.toInt()} lesson',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SfCartesianChart(
                    backgroundColor: hexStringToColor('6E6BFC'),
                    plotAreaBorderWidth: 0,
                    borderColor: Colors.transparent,
                    primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0.1),
                        majorTickLines: const MajorTickLines(width: 0),
                        axisLine: const AxisLine(width: 0),
                        labelPlacement: LabelPlacement.betweenTicks,
                        labelStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    primaryYAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(width: 0.1),
                      majorTickLines: const MajorTickLines(width: 0),
                      axisLine: const AxisLine(width: 0),
                      labelStyle: const TextStyle(
                          color: Colors.transparent, fontSize: 0),
                    ),
                    series: <SplineAreaSeries<WeekDayData, String>>[
                      SplineAreaSeries<WeekDayData, String>(
                          dataSource: controller.data.toList(),
                          xValueMapper: (WeekDayData sales, _) => sales.day,
                          yValueMapper: (WeekDayData sales, _) => sales.value,
                          cardinalSplineTension: -0.5,
                          splineType: SplineType.cardinal,
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromRGBO(255, 255, 252, 0.7),
                              Color.fromRGBO(95, 92, 250, 0.4),
                            ],
                          ),
                          borderWidth: 3,
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                          ),
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              useSeriesColor: true,
                              color: Colors.red,
                              labelAlignment: ChartDataLabelAlignment.top)),
                    ],
                  ),
                ),
              )
            ]),
          );
        });
  }
}

class WeekDayData {
  final String day;
  late int value;

  WeekDayData(this.day, this.value);
}
