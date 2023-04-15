import 'package:eppo/constants/colors.dart';
import 'package:eppo/screens/disease_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:camera/camera.dart';
import 'package:lottie/lottie.dart';

class DiseaseScanScreen extends StatefulWidget {
  const DiseaseScanScreen({super.key});

  @override
  State<DiseaseScanScreen> createState() => _DiseaseScanScreenState();
}

class _DiseaseScanScreenState extends State<DiseaseScanScreen> {
  late CameraController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializationCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AspectRatio(
                          aspectRatio: 5 / 11.11,
                          child: CameraPreview(controller)),
                    ],
                  ),
                  Center(
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Lottie.asset('assets/lottie/scan.json'),
                    ),
                  ),
                  InkWell(
                    onTap: () => onTakePicture(),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: MyColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> initializationCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[EnumCameraDescription.back.index],
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await controller.initialize();
  }

  void onTakePicture() async {
    await controller.takePicture().then((XFile xfile) {
      print('xfile.path: ${xfile.path}');
      if (mounted) {
        if (xfile != null) {
          Navigator.of(context).pushNamed('/ddetail', arguments: DDArgs(xfile));
        }
      }
      return;
    });
  }
}

enum EnumCameraDescription { back, front }
