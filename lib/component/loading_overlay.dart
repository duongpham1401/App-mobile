import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  // ignore: library_private_types_in_public_api
  static _LoadingOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<_LoadingOverlayState>()!;
  }

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        // Positioned.fill(
        //   top: 0.0,
        //   left: 0.0,
        //   right: 0.0,
        //   bottom: 0.0,
        //   child: Container(
        //     color: Colors.black.withOpacity(0.7),
        //   ),
        // ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
