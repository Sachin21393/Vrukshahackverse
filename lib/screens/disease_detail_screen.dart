import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eppo/constants/colors.dart';
import 'package:eppo/models/disease_model.dart';
import 'package:eppo/services/ml_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DDArgs {
  final XFile image;
  DDArgs(this.image);
}

class DiseaseDetailScreen extends StatefulWidget {
  const DiseaseDetailScreen({super.key});

  @override
  State<DiseaseDetailScreen> createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DDArgs;

    print(args.image.path);
    return FutureBuilder<DiseaseModel>(
        future: MlService().predictDisease(
            base64Encode(File(args.image.path).readAsBytesSync())),
        builder: (context, snapshot) {
          if (snapshot == null || !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var disease = snapshot.data!;
          return Scaffold(
              body: Stack(
            children: [
              Image.asset('assets/images/bg.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.topCenter),
              SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            Text(
                              'Plant Growth',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                            Text("")
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                          width: double.infinity,
                          child: AspectRatio(
                              aspectRatio: 3 / 2,
                              child: Image.file(File(args.image.path),
                                  fit: BoxFit.cover))),
                      const SizedBox(height: 20),
                      diseaseDetail(disease),
                      const SizedBox(height: 20),
                      plantProgresss()
                    ],
                  ),
                ),
              )
            ],
          ));
        });
  }

  Column plantProgresss() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Growing up process',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: '30',
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
                TextSpan(
                    text: '/70 days',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14))
              ])),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Image.asset(
                    'assets/images/graph.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Vegitative',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)),
                const SizedBox(height: 5),
                Text('1 Week left',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12))
              ],
            )),
            RotatedBox(
              quarterTurns: -1,
              child: Column(
                children: [
                  Text('Pre-flowering',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  const SizedBox(height: 5),
                  Text('2-3 week left',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Column diseaseDetail(DiseaseModel disease) {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(width: 10),
            Text('Disease Detection',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: const [
            SizedBox(width: 10),
            Text('16:34 PM - 06.08.2022',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12)),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/bs1.png',
                    fit: BoxFit.cover, height: 90, width: 90),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(disease.disease,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(disease.remedy,
                      maxLines: 3,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: const Text('View Details',
                              style: TextStyle(
                                  color: MyColors.blueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        )
      ],
    );
  }
}

class GrowingChart extends StatefulWidget {
  const GrowingChart({super.key});

  @override
  State<GrowingChart> createState() => _GrowingChartState();
}

class _GrowingChartState extends State<GrowingChart> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
