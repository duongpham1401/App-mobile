import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_app/component/weekly_exercise_chart.dart';
import 'package:get/get.dart';

class WeeklyChartController extends GetxController {
  final String userId;

  WeeklyChartController({
    required this.userId,
  });

  var data = RxList<WeekDayData>([
    WeekDayData('Mon', 0),
    WeekDayData('Tue', 0),
    WeekDayData('Wed', 0),
    WeekDayData('Thu', 0),
    WeekDayData('Fri', 0),
    WeekDayData('Sat', 0),
    WeekDayData('Sun', 0),
  ]);

  var total = RxInt(0);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  void getData() async {
    // Lấy thời gian hiện tại
    DateTime now = DateTime.now();

    // Tính toán ngày bắt đầu và kết thúc của tuần hiện tại
    int currentWeekday = now.weekday; // lấy thứ hiện tại
    // Lấy ngày nhưng có giờ bị sai
    DateTime startOfWeekError =
        now.subtract(Duration(days: now.weekday - 1)).toUtc();
    DateTime endOfWeekError = startOfWeekError
        .add(Duration(days: 6))
        .add(Duration(hours: 23, minutes: 59, seconds: 59))
        .toUtc();

    // Đặt lại giờ cho ngày
    DateTime _start = DateTime(startOfWeekError.year, startOfWeekError.month,
        startOfWeekError.day, 0, 0);
    DateTime _end = DateTime(endOfWeekError.year, endOfWeekError.month,
        endOfWeekError.day, 23, 59, 59);

    // Truy vấn Firestore để lấy ra số lượng dòng có status là "Completed" và nằm trong khoảng thời gian của tuần hiện tại
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('progress')
        .where('status', isEqualTo: 'Completed')
        .where('userId', isEqualTo: userId)
        .where('timestamp', isGreaterThanOrEqualTo: _start)
        .where('timestamp', isLessThanOrEqualTo: _end)
        .get();

    total.value = querySnapshot.size;

    data.assignAll([
      WeekDayData('Mon', 0),
      WeekDayData('Tue', 0),
      WeekDayData('Wed', 0),
      WeekDayData('Thu', 0),
      WeekDayData('Fri', 0),
      WeekDayData('Sat', 0),
      WeekDayData('Sun', 0),
    ]);

    // Lặp qua các tài liệu trong querySnapshot để cập nhật số lượng hoàn thành cho mỗi ngày trong tuần
    querySnapshot.docs.forEach((doc) {
      DateTime timestamp =
          (doc.data() as Map<String, dynamic>)['timestamp'].toDate();
      int weekday = timestamp.weekday;
      data[weekday - 1].value++;
    });

    update();
  }
}
