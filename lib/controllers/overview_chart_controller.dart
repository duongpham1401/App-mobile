import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OverviewChartController extends GetxController {
  final String userId;

  OverviewChartController({
    required this.userId,
  });

  var totalLesson = RxInt(0);
  var totalLessonVocabulary = RxInt(0);
  var totalLessonGrammar = RxInt(0);
  var totalLessonListen = RxInt(0);

  var totalCompleted = RxInt(0);
  var totalVCompleted = RxInt(0);
  var totalGCompleted = RxInt(0);
  var totalLCompleted = RxInt(0);

  var totalInProgess = RxInt(0);
  var totalVInProgess = RxInt(0);
  var totalGInProgess = RxInt(0);
  var totalLInProgess = RxInt(0);

  var totalNotStart = RxInt(0);
  var totalVNotStart = RxInt(0);
  var totalGNotStart = RxInt(0);
  var totalLNotStart = RxInt(0);

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
    // Total Lesson
    QuerySnapshot totalV = await FirebaseFirestore.instance
        .collectionGroup('vocabulary_topics')
        .get();
    totalLessonVocabulary.value = totalV.size;

    QuerySnapshot totalG = await FirebaseFirestore.instance
        .collectionGroup('grammar_topics')
        .get();
    totalLessonGrammar.value = totalG.size;

    QuerySnapshot totalL =
        await FirebaseFirestore.instance.collectionGroup('listen_topics').get();
    totalLessonListen.value = totalL.size;

    totalLesson.value = totalV.size + totalG.size + totalL.size;

    //In Progess
    QuerySnapshot inProgressV = await FirebaseFirestore.instance
        .collection('progress')
        .where('typeId', isEqualTo: 1)
        .where('status', isEqualTo: 'In Progress')
        .where('userId', isEqualTo: userId)
        .get();
    totalVInProgess.value = inProgressV.size;

    QuerySnapshot inProgressG = await FirebaseFirestore.instance
        .collection('progress')
        .where('typeId', isEqualTo: 2)
        .where('status', isEqualTo: 'In Progress')
        .where('userId', isEqualTo: userId)
        .get();
    totalGInProgess.value = inProgressG.size;

    QuerySnapshot inProgressL = await FirebaseFirestore.instance
        .collection('progress')
        .where('typeId', isEqualTo: 3)
        .where('status', isEqualTo: 'In Progress')
        .where('userId', isEqualTo: userId)
        .get();
    totalLInProgess.value = inProgressL.size;

    totalInProgess.value = totalVInProgess.value + totalGInProgess.value + totalLInProgess.value;

    //Completed
    QuerySnapshot completedV = await FirebaseFirestore.instance
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .where('typeId', isEqualTo: 1)
        .where('status', isEqualTo: 'Completed')
        .orderBy('topicId')
        .get();
    Map<String, Map<String, dynamic>> documentsV = {};
    completedV.docs.forEach((doc) {
      String topicId = doc['topicId'].toString();
      if (!documentsV.containsKey(topicId)) {
        documentsV[topicId] = {
          'count': 1,
          'docs': [doc.data()]
        };
      } else {
        documentsV[topicId]!['count']++;
        documentsV[topicId]!['docs']?.add(doc.data());
      }
    });
    totalVCompleted.value = documentsV.length;

    QuerySnapshot completedG = await FirebaseFirestore.instance
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .where('typeId', isEqualTo: 2)
        .where('status', isEqualTo: 'Completed')
        .orderBy('topicId')
        .get();
    Map<String, Map<String, dynamic>> documentsG = {};
    completedG.docs.forEach((doc) {
      String topicId = doc['topicId'].toString();
      if (!documentsG.containsKey(topicId)) {
        documentsG[topicId] = {
          'count': 1,
          'docs': [doc.data()]
        };
      } else {
        documentsG[topicId]!['count']++;
        documentsG[topicId]!['docs']?.add(doc.data());
      }
    });
    totalGCompleted.value = documentsG.length;

    QuerySnapshot completedL = await FirebaseFirestore.instance
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .where('typeId', isEqualTo: 3)
        .where('status', isEqualTo: 'Completed')
        .orderBy('topicId')
        .get();
    Map<String, Map<String, dynamic>> documentsL = {};
    completedL.docs.forEach((doc) {
      String topicId = doc['topicId'].toString();
      if (!documentsL.containsKey(topicId)) {
        documentsL[topicId] = {
          'count': 1,
          'docs': [doc.data()]
        };
      } else {
        documentsL[topicId]!['count']++;
        documentsL[topicId]!['docs']?.add(doc.data());
      }
    });
    totalLCompleted.value = documentsL.length;

    totalCompleted.value = totalVCompleted.value + totalGCompleted.value + totalLCompleted.value;

    // Not Started
    totalVNotStart.value = totalLessonVocabulary.value -
        totalVCompleted.value -
        totalVInProgess.value;

    totalGNotStart.value = totalLessonGrammar.value -
        totalGCompleted.value -
        totalGInProgess.value;

    totalLNotStart.value = totalLessonListen.value -
        totalLCompleted.value -
        totalLInProgess.value;

    totalNotStart.value = totalVNotStart.value + totalGNotStart.value + totalLNotStart.value;
  }
}
