import 'package:flutter/material.dart';

Container vocabularyTopicView(BuildContext context, String imageUrl,
    String topicName, String topicStatus, Function onTap) {
  // ignore: no_leading_underscores_for_local_identifiers
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Not Started':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  return Container(
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: _getStatusColor(topicStatus),
        width: 2,
      ),
    ),
    child: GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.translucent,
      child: Card(
        elevation: 0.0,
        child: Stack(
          children: [
            SizedBox(
                height: 200,
                child: Image.network(
                  height: 200,
                  width: 370,
                  imageUrl,
                  fit: BoxFit.fill,
                )),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(topicStatus),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  topicStatus,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  topicName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
