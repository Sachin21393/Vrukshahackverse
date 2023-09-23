import 'package:dots_indicator/dots_indicator.dart';
import 'package:eppo/constants/colors.dart';
import 'package:eppo/models/plant_rec_mode.dart';
import 'package:eppo/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ObFormScreen extends StatefulWidget {
  const ObFormScreen({super.key});

  @override
  State<ObFormScreen> createState() => _ObFormScreenState();
}

class ObFormArgs {
  final String name;
  ObFormArgs({required this.name});
}

class _ObFormScreenState extends State<ObFormScreen> {
  var _selectedMode = -1;
  var _selectedSpace = -1;
  var _selectedPage = 0.0;
  String? _selectedPlant = null;
  PlantRec? _plantDetail = null;
  @override
  Widget build(BuildContext context) {
    final ObFormArgs args =
        ModalRoute.of(context)!.settings.arguments as ObFormArgs;
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            // ignore: prefer_const_literals_to_create_immutables
            child: Column(children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'What a great name!',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      args.name.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 26),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Now, can you tell us where will you grow:',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              indoorSelector(),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'And what kind of space will you grow in:',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  spaceWidget('assets/images/p1.svg', 'Planter Box', 0),
                  const SizedBox(
                    width: 10,
                  ),
                  spaceWidget('assets/images/p2.svg', 'Ground', 1),
                  const SizedBox(
                    width: 10,
                  ),
                  spaceWidget('assets/images/p3.svg', 'Raised Bed', 2)
                ],
              ),
              const SizedBox(height: 30),
              richTextWidget(args),
              const SizedBox(height: 20),
              if (_selectedMode != -1 && _selectedSpace != -1)
                optionsSelector(),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_selectedPlant != null) {
                            showInstructions(context);
                          }
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
              )
            ]),
          ),
        ));
  }

  Future<dynamic> showInstructions(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('Instructions for planting trees',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: PageView(
                      onPageChanged: (idx) {
                        setState(() {
                          print(idx);
                          _selectedPage = idx * 1.0;
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                  height: 150,
                                  child: Image.asset('assets/images/ins1.png')),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                _plantDetail!.procedure,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                  height: 150,
                                  child: Image.asset('assets/images/ins2.png')),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                _plantDetail!.description,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                  height: 150,
                                  child: Image.asset('assets/images/ins3.png')),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                _plantDetail!.duration,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                maxLines: 4,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    DotsIndicator(
                        dotsCount: 3,
                        position: _selectedPage * 1.0,
                        decorator: DotsDecorator(
                            color: Colors.grey,
                            activeColor: MyColors.primaryColor,
                            activeSize: const Size.square(9.0),
                            size: const Size.square(9.0),
                            spacing: const EdgeInsets.all(5.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)))),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/qrtype');
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                        backgroundColor: MyColors.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  FutureBuilder<List<PlantRec>> optionsSelector() {
    return FutureBuilder<List<PlantRec>>(
        future:
            ApiService().getPlantRec(_selectedMode == 0 ? 'Indoor' : 'Outdoor'),
        builder: (context, snapshot) {
          if (snapshot == null || !snapshot.hasData)
            return const CircularProgressIndicator();
          var data = snapshot.data;
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => setState(() {
                                  _selectedPlant = data![index].plant;
                                  _plantDetail = data![index];
                                  Navigator.pop(context);
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(data![index].plant),
                                    subtitle: Text(
                                      data![index].description,
                                      style: const TextStyle(),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  });
            },
            child: Container(
              width: double.infinity,
              height: 60,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFFE6E6E6), width: 1)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      _selectedPlant ?? 'Select an option',
                      style: const TextStyle(
                          color: Color(0xFFBDBDBD), fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFFBDBDBD),
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Row richTextWidget(ObFormArgs args) {
    return Row(
      children: [
        Expanded(
            child: RichText(
          text: TextSpan(children: [
            const TextSpan(
                text: 'What kind of plants will ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
            TextSpan(
                text: args.name,
                style: const TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
            const TextSpan(
                text: ' have?',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
          ]),
        ))
      ],
    );
  }

  Expanded spaceWidget(String image, String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _selectedSpace = index;
        }),
        child: Column(children: [
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: MyColors.primaryColor,
                    width: _selectedSpace == index ? 2.0 : 0.0),
              ),
              color: MyColors.silverColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(image, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
          )
        ]),
      ),
    );
  }

  Row indoorSelector() {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 60,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  color:
                      _selectedMode == 0 ? MyColors.primaryColor : Colors.grey,
                  width: 1.0),
            ),
            color: _selectedMode == 0 ? MyColors.primaryColor : Colors.white,
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedMode = 0;
                });
              },
              child: Center(
                child: Text(
                  'Indoor',
                  style: TextStyle(
                      color: _selectedMode == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        )),
        Expanded(
            child: Container(
          height: 60,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  color:
                      _selectedMode == 1 ? MyColors.primaryColor : Colors.grey,
                  width: 1.0),
            ),
            color: _selectedMode == 1 ? MyColors.primaryColor : Colors.white,
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedMode = 1;
                });
              },
              child: Center(
                child: Text(
                  'Outdoor',
                  style: TextStyle(
                      color: _selectedMode == 1 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
