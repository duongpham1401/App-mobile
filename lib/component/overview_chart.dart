import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/controllers/overview_chart_controller.dart';
import 'package:english_app/reusable_widgets/reusable_widget.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverviewChart extends StatefulWidget {
  const OverviewChart({Key? key}) : super(key: key);

  @override
  State<OverviewChart> createState() => _OverviewChartState();
}

class _OverviewChartState extends State<OverviewChart> {
  final AuthController _controller = Get.put(AuthController());
  late String uid;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, activationMode: ActivationMode.singleTap);
    uid = _controller.getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<OverviewChartController>(
        init: OverviewChartController(userId: uid),
        builder: (controller) {
          List<TotalChartData> totalChartData = [
            TotalChartData(
                'Completed', controller.totalCompleted.toInt(), Colors.green),
            TotalChartData('In Progress', controller.totalInProgess.toInt(),
                Colors.orange),
            TotalChartData(
                'Not Started', controller.totalNotStart.toInt(), Colors.red),
          ];

          return Container(
              decoration: BoxDecoration(
                color: hexStringToColor('6E6BFC'),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                  ),
                ],
              ),
              width: double.infinity,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180,
                          child: SfCircularChart(
                              tooltipBehavior: _tooltipBehavior,
                              legend: Legend(
                                  isVisible: true,
                                  textStyle: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                  title: LegendTitle(
                                      alignment: ChartAlignment.center,
                                      text: 'Status',
                                      textStyle: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w900))),
                              annotations: <CircularChartAnnotation>[
                                CircularChartAnnotation(
                                    widget: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                          child: Text(
                                              '${controller.totalLesson}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                  ),
                                ))
                              ],
                              series: <CircularSeries>[
                                DoughnutSeries<TotalChartData, String>(
                                  dataSource: totalChartData,
                                  radius: '100%',
                                  innerRadius: '40%',
                                  pointColorMapper: (TotalChartData data, _) =>
                                      data.color,
                                  xValueMapper: (TotalChartData data, _) =>
                                      data.type,
                                  yValueMapper: (TotalChartData data, _) =>
                                      data.value,
                                  enableTooltip: true,
                                  // dataLabelSettings: DataLabelSettings(isVisible:true),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 25,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Completed',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${controller.totalCompleted} (${(controller.totalCompleted.toInt() * 100 / controller.totalLesson.toInt()).toStringAsFixed(2)}%)',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'In Progress',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      '${controller.totalInProgess} (${(controller.totalInProgess.toInt() * 100 / controller.totalLesson.toInt()).toStringAsFixed(2)}%)',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Not Started',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${controller.totalNotStart} (${(controller.totalNotStart.toInt() * 100 / controller.totalLesson.toInt()).toStringAsFixed(2)}%)',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(thickness: 1,),
                        progressWidget(
                            context,
                            'Vocabulary',
                            controller.totalLessonVocabulary.toInt() == 0
                                ? 10
                                : controller.totalLessonVocabulary.toInt(),
                            controller.totalVCompleted.toInt(),
                            controller.totalVInProgess.toInt(),
                            controller.totalVNotStart.toInt(),
                            () {}),
                        progressWidget(
                            context,
                            'Grammar',
                            controller.totalLessonGrammar.toInt() == 0
                                ? 10
                                : controller.totalLessonGrammar.toInt(),
                            controller.totalGCompleted.toInt(),
                            controller.totalGInProgess.toInt(),
                            controller.totalGNotStart.toInt(),
                            () {}),
                        progressWidget(
                            context,
                            'Listen',
                            controller.totalLessonListen.toInt() == 0
                                ? 10
                                : controller.totalLessonListen.toInt(),
                            controller.totalLCompleted.toInt(),
                            controller.totalLInProgess.toInt(),
                            controller.totalLNotStart.toInt(),
                            () {}),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}

class TotalChartData {
  TotalChartData(this.type, this.value, this.color);

  final String type;
  final int value;
  final Color color;
}
