import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety_app/views/criminal_recognition/dummy_data_processor.dart';
import 'dart:async';

class CriminalRecognitionScreen extends StatefulWidget {
  const CriminalRecognitionScreen({super.key});

  @override
  State<CriminalRecognitionScreen> createState() =>
      _CriminalRecognitionScreenState();
}

class _CriminalRecognitionScreenState extends State<CriminalRecognitionScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  late Criminal criminalData;
  bool isScanning = false;
  int criminalIndex = 0;

  @override
  void initState() {
    super.initState();
    criminalData = getCriminals()[criminalIndex];
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  void startScanning() async {
    setState(() {
      isScanning = true;
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        isScanning = false;
        // Get the list of criminals and reset the index if necessary
        List<Criminal> criminals = getCriminals();
        criminalData = criminals[criminalIndex];

        // Update the index and reset if necessary
        criminalIndex += 1;
        if (criminalIndex >= criminals.length) {
          criminalIndex = 0; // Reset index when reaching the end of the list
        }
      });

      Get.dialog(
        AlertDialog(
          title: const Text('Criminal Found'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.asset(
                  height: Get.height / 4,
                  width: Get.width / 2,
                  criminalData.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                /*  leading: CircleAvatar(
                  backgroundImage: AssetImage(criminalData.imageUrl),
                ), */
                title: Text(criminalData.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        criminalData.gender.toLowerCase() == "male"
                            ? const Icon(
                                Icons.male,
                                color: Colors.blue,
                              )
                            : const Icon(
                                Icons.female,
                                color: Colors.pink,
                              ),
                        Text(criminalData.gender),
                      ],
                    ),
                    Text('Criminal ID: ${criminalData.id}'),
                    Text('Past Violations: ${criminalData.charge}'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criminal Recognition'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CameraPreview(_cameraController,
                        child: Lottie.asset("lib/res/lottie/face_scan.json",
                            fit: BoxFit.fitWidth)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isScanning
                            ? Column(
                                children: [
                                  Lottie.asset(
                                      "lib/res/lottie/scanning_square.json",
                                      height: 130),
                                  const Text(
                                    "Running face detection...",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 20),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  const Text(
                                    'Face Recognition System',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    iconSize: 50,
                                    onPressed: startScanning,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text('Click the camera to scan'),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
