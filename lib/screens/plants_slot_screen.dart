import 'package:eppo/screens/plant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantSlotScreen extends StatefulWidget {
  const PlantSlotScreen({super.key});

  @override
  State<PlantSlotScreen> createState() => _PlantSlotScreenState();
}

class _PlantSlotScreenState extends State<PlantSlotScreen> {
  List<String?> slots = [
    null,
    null,
    null,
    null,
    null,
    null,
    "potato",
    "clivia",
    "Leten Rose",
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    "clivia",
    null
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset('assets/images/bg.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter),
        SafeArea(
          child: Column(
            children: [
              Container(
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
                      'My Garden',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    const Text("")
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GridView.builder(
                        itemCount: slots.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              if (slots[index] == null) {
                                Navigator.of(context).pushNamed('/add_slot');
                              } else {
                                Navigator.of(context).pushNamed('/plantdetail',
                                    arguments: PdArgs(slots[index]!));
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: SvgPicture.asset(slots[index] == null
                                      ? 'assets/images/add_slot.svg'
                                      : 'assets/images/used_slot.svg')),
                            ),
                          );
                        }),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
