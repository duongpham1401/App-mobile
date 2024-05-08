import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('/types/4T76D7SuhdeNMJRWSRj0/vocabulary_topics/1fCTsYchYiFy77t3wHKd/vocabulary_quiz');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            "id": 2,
            "topicId": 4,
            "answerA": 'A. Rain',
            "answerB": "B. Wind",
            "answerC": "C. Storm",
            "answerD": "D. Snow",
            "correctAnswer": "B",
            "questionImg": "https://cdn.britannica.com/65/123865-050-687A9E4C/Rain.jpg",
          })
          .then((value) => print("Data Added"))
          .catchError((error) => print("Failed to add data: $error"));
    }

    return Center(
      child: ElevatedButton(
          onPressed: () {
            addUser();
          },
          child: Text('add')),
    );
  }
}
