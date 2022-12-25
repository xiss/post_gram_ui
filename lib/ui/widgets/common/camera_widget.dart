import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  final Function(File) onFile;
  final String title;

  const CameraWidget({super.key, required this.onFile, required this.title});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future asyncInit() async {
    List<CameraDescription> cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> isTakingPhoto = Future.value(false);
    if (!(controller?.value.isInitialized ?? false)) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    CameraValue camera = controller!.value;
    return LayoutBuilder(
      builder: (_, constraints) {
        double scale = (min(constraints.maxHeight, constraints.maxWidth) /
                max(constraints.maxWidth, constraints.maxHeight)) *
            camera.aspectRatio;
        if (scale < 1) {
          scale = 1 / scale;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Transform.scale(
                  scale: scale,
                  child: Center(
                    child: CameraPreview(controller!),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!.withAlpha(200),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                        icon: const Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (!await isTakingPhoto) {
                            isTakingPhoto = Future.value(true);
                            XFile photo = await controller!.takePicture();
                            widget.onFile(File(photo.path));
                            isTakingPhoto = Future.value(false);
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
