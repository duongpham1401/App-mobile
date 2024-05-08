import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  static ProgressController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<bool> isHasProgress(int topicId, int typeId) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    QuerySnapshot progress = await _db
        .collection('progress')
        .where('userId', isEqualTo: currentUser?.uid)
        .where('typeId', isEqualTo: typeId)
        .where('topicId', isEqualTo: topicId)
        .get();

    if (progress.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> isInProgress(int topicId, int typeId) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    QuerySnapshot progress = await _db
        .collection('progress')
        .where('userId', isEqualTo: currentUser?.uid)
        .where('typeId', isEqualTo: typeId)
        .where('topicId', isEqualTo: topicId)
        .where('status', isEqualTo: 'In Progress')
        .get();

    if (progress.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  // Thêm mới tiến trình
  Future<void> addProcess(int topicId, int typeId, bool isComplete) {
    CollectionReference progress =
        FirebaseFirestore.instance.collection('progress');

    DateTime now = DateTime.now();

    var currentUser = FirebaseAuth.instance.currentUser;

    final status = isComplete ? 'Completed' : 'In Progress';

    return progress
        .add({
          "userId": currentUser?.uid,
          "topicId": topicId,
          "typeId": typeId,
          "status": status,
          "timestamp": now,
        })
        .then((value) => print("Progress Added"))
        .catchError((error) => print("Failed to add progress: $error"));
  }

  // Update những tiến trình chưa hoàn thành
  Future<void> updateProcess(int topicId, int typeId) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    DateTime now = DateTime.now();

    await _db
        .collection('progress')
        .where('userId', isEqualTo: currentUser?.uid)
        .where('typeId', isEqualTo: typeId)
        .where('topicId', isEqualTo: topicId)
        .where('status', isEqualTo: 'In Progress')
        .get()
        .then((querySnapshot) {
          querySnapshot.docs.forEach((document) {
            document.reference.update({
              'status': 'Completed',
              "timestamp": now,
            });
          });
        })
        .then((value) => print("Cập nhật trạng thái thành công"))
        .catchError((error) => print("Lỗi khi cập nhật trạng thái: $error"));
  }
}
