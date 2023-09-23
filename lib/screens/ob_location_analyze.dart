import 'package:eppo/constants/colors.dart';
import 'package:eppo/models/temp_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/api_service.dart';

class ObLocationAnalysis extends StatefulWidget {
  const ObLocationAnalysis({super.key});

  @override
  State<ObLocationAnalysis> createState() => _ObLocationAnalysisState();
}

class _ObLocationAnalysisState extends State<ObLocationAnalysis> {
  double progress = 0.25;
  String a1 = '';
  String a2 = '';
  String a3 = '';
  String a4 = '';
  bool apiDOne = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAnalysis();
  }

  fetchAnalysis() async {
    TempRes res = await ApiService().getTemp();
    print(res);
    setState(() {
      a1 = res.ph.toString();
      a2 = res.humidity.toString();
      a3 = res.weather..toString();
      a4 = res.temperature.toString();
      apiDOne = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Analyzing',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(children: [
            Stack(
              children: [
                Container(
                    height: 6,
                    width: MediaQuery.of(context).size.width,
                    color: MyColors.silverColor),
                Container(
                    height: 6,
                    width: MediaQuery.of(context).size.width * progress,
                    color: MyColors.primaryColor),
              ],
            )
          ]),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline,
                    color: MyColors.primaryColor),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current address',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    const Text('NIT Surathkal, Karnataka, India',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          tile('a1.png', 'pH', a1),
          const SizedBox(height: 20),
          tile('a2.png', 'Humidity', a2),
          const SizedBox(height: 20),
          tile('a3.png', 'Sunlight', a3),
          const SizedBox(height: 20),
          tile('a4.png', 'Temprature', a4),
          const SizedBox(
            height: 10,
          ),
          if (apiDOne)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/tick.png',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Analysis completed!',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/obname');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Continue')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container tile(String img, String title, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 80,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFFE6E6E6), width: 1)),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/${img}',
              height: 50,
              width: 50,
            ),
            SizedBox(
              width: 10,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(value,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
