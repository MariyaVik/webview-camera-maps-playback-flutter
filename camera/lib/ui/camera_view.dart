import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../images.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late List<CameraDescription> cameras;
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    unawaited(initCamera());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        controller?.value.isInitialized == true
            ? Center(child: CameraPreview(controller!))
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.blue, shape: BoxShape.circle),
              child: IconButton(
                  iconSize: 48,
                  onPressed: () async {
                    if (controller?.value.isInitialized == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Обработка...'),
                        ),
                      );
                      final picture = await controller!.takePicture();
                      images.add(picture);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Снимок добавлен в галерею'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.camera)),
            ),
          ),
        )
      ],
    );
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller!.initialize();
    if (mounted) setState(() {});
  }
}
