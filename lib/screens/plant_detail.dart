import 'package:eppo/models/plant_specs_model.dart';
import 'package:eppo/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PlantDetailScreen extends StatefulWidget {
  const PlantDetailScreen({super.key});

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class PdArgs {
  final String plantId;
  PdArgs(this.plantId);
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countDown); // Create instance.

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.setPresetMinuteTime(1);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    final PdArgs args = ModalRoute.of(context)!.settings.arguments as PdArgs;
    print(args.plantId);
    return Scaffold(
        body: Stack(
      children: [
        Image.asset('assets/images/bg.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter),
        FutureBuilder<PlantSpecs>(
            future: ApiService().getPlantSpecs(args.plantId),
            builder: (context, snapshot) {
              if (snapshot == null || !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final PlantSpecs data = snapshot.data!;
              return SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  topBar(context),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        args.plantId,
                        style: const TextStyle(
                            color: Color(0xFF317D53),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  statsWidget(data),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('Overview',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  weatherStats(data),
                  const SizedBox(height: 20),
                  dailyForcasts(data),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('Plant Bio',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(data.data.plantbio,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.youtube.length,
                          itemBuilder: ((context, index) => GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              data.youtube[index].thumbnail,
                                              fit: BoxFit.cover,
                                              width: 150,
                                              height: 100,
                                            ),
                                          ),
                                          Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Icon(Icons.play_circle,
                                                  color: Colors.white,
                                                  size: 30))
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: 180,
                                        child: Text(
                                          data.youtube[index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))))
                ],
              )));
            })
      ],
    ));
  }

  Column dailyForcasts(PlantSpecs data) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Daily forecast',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    forecast('10:00', 'assets/images/sun.svg'),
                    forecast('11:00', 'assets/images/sun.svg'),
                    forecast('12:00', 'assets/images/sun.svg'),
                    forecast('13:00', 'assets/images/sun.svg'),
                    forecast('14:00', 'assets/images/sun.svg'),
                    forecast('15:00', 'assets/images/drizzle.svg'),
                  ],
                ),
              )),
        )
      ],
    );
  }

  Column forecast(String time, String icon) {
    return Column(
      children: [
        Text(time,
            style: const TextStyle(
                color: Color(0xFF333333),
                fontWeight: FontWeight.w500,
                fontSize: 12)),
        const SizedBox(height: 10),
        SvgPicture.asset(icon, width: 20, height: 20),
      ],
    );
  }

  Container weatherStats(PlantSpecs data) {
    return Container(
      width: double.infinity,
      child: Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/ph.svg', width: 20, height: 20),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(data.whetherdata.ph.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D986A))),
                  const SizedBox(height: 5),
                  const Text('pH',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333)))
                ],
              )
            ],
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/temp.svg', width: 24, height: 24),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text('${data.whetherdata.temperature}° C',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D986A))),
                  SizedBox(height: 5),
                  Text('TEMP',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333)))
                ],
              )
            ],
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/humidity.svg',
                  width: 20, height: 20),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text('${data.whetherdata.humidity}%',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D986A))),
                  SizedBox(height: 5),
                  Text('HUMIDITY',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333)))
                ],
              )
            ],
          ))
        ],
      )),
    );
  }

  Row statsWidget(PlantSpecs data) {
    return Row(
      children: [
        Expanded(flex: 6, child: Image.asset('assets/images/sage.png')),
        Expanded(
            flex: 4,
            child: Column(
              children: [
                countDown(data),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('PLANT STATUS',
                                    style: TextStyle(
                                        color: Color(0xFF0D986A),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text('Status: ${data.data.status}',
                                style: const TextStyle(
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                            const SizedBox(height: 5),
                            Text('Frequency: ${data.data.frequency} times/day',
                                style: const TextStyle(
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                            const SizedBox(height: 5),
                            Text('Weather: ${data.whetherdata.weather}',
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                            const SizedBox(height: 5),
                            const Text('Pot: Vriksha\'s Smart Pot',
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                          ],
                        )),
                  ),
                )
              ],
            ))
      ],
    );
  }

  Column countDown(PlantSpecs data) {
    return Column(
      children: [
        const Text('Until next watering time',
            style: TextStyle(
                color: Color(0xFF317D53),
                fontWeight: FontWeight.bold,
                fontSize: 12)),
        const SizedBox(height: 10),
        StreamBuilder<int>(
          stream: _stopWatchTimer.secondTime,
          initialData: 0,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime = StopWatchTimer.getDisplayTime(value!);
            return Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            displayTime,
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: 'Helvetica',
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            );
          },
        ),
      ],
    );
  }

  Container topBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 16,
            ),
          ),
          const Text(
            'Plant Analysis',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const Text("")
        ],
      ),
    );
  }
}
