import 'package:carousel_slider/carousel_slider.dart';
import 'package:eppo/constants/colors.dart';
import 'package:eppo/screens/plant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class Task {
  final String image;
  final String time;
  final String ml;
  final String title;
  final bool isWatering;
  final String id;

  Task(this.image, this.time, this.ml, this.title, this.isWatering, this.id);
}

class Product {
  final String image;
  final String name;
  final int price;

  Product(this.image, this.name, this.price);
}

class Blog {
  final String image;
  final String title;

  Blog(this.image, this.title);
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  final List<String> sliders = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
  ];

  final List<Task> tasks = [
    Task('assets/images/task1.png', 'Today 2:00 pm', 'With 100ml', 'Watering',
        true, "clivia"),
    Task('assets/images/task2.png', 'Today 4:00 pm', 'With 200ml', 'Watering',
        true, "Leten Rose"),
    Task('assets/images/task3.png', 'Today 7:00 pm', 'With 100ml', 'Cutting',
        false, "Lamb's Ear"),
  ];
  final List<Product> recs = [
    Product('assets/images/rec1.png', 'Butterfly Pea', 75),
    Product('assets/images/rec2.png', 'Lavender', 130),
    Product('assets/images/rec3.png', 'Strawberry', 45),
  ];
  final List<Product> bestsellers = [
    Product('assets/images/bs1.png', 'Butterfly Pea', 75),
    Product('assets/images/bs2.png', 'Lavender', 130),
    Product('assets/images/bs3.png', 'Strawberry', 45),
  ];

  final List<Blog> blogs = [
    Blog('assets/images/blog1.png', 'How to grow a plant'),
    Blog('assets/images/blog2.png', 'How to grow a plant'),
    Blog('assets/images/blog1.png', 'How to grow a plant'),
    Blog('assets/images/blog2.png', 'How to grow a plant'),
  ];

  var _selectedSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: MyColors.silverColor,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10),
          topSlider(),
          const SizedBox(
            height: 5,
          ),
          myTasks(),
          const SizedBox(
            height: 16,
          ),
          recommendedForYou('Recommended for you', recs),
          const SizedBox(
            height: 16,
          ),
          recommendedForYou('Weekly best sellers', bestsellers),
          const SizedBox(
            height: 16,
          ),
          showBlogs('Curated blogs for you', blogs)
        ]),
      ),
    );
  }

  Container showBlogs(String header, List<Blog> recs) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: MyColors.blueColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: GridView.builder(
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (ctx, idx) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              recs[idx].image,
                              fit: BoxFit.cover,
                              width: 130,
                              height: 130,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            recs[idx].title,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF222222),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                itemCount: recs.length),
          )
        ],
      ),
    );
  }

  Container recommendedForYou(String header, List<Product> recs) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: MyColors.blueColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
                itemCount: recs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                recs[index].image,
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              recs[index].name,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "${recs[index].price} ₹",
                              style: const TextStyle(
                                  fontSize: 13, color: Color(0xFF666666)),
                            )
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }

  Container myTasks() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Tasks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/tasks');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'All tasks',
                      style: TextStyle(color: MyColors.blueColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
                itemCount: tasks.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/plantdetail',
                            arguments: PdArgs(tasks[index].id));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(children: [
                                Image.asset(
                                  tasks[index].image,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 100,
                                ),
                                if (tasks[index].isWatering)
                                  Positioned(
                                      top: 8,
                                      right: 10,
                                      child: SvgPicture.asset(
                                        'assets/images/watering.svg',
                                        height: 28,
                                        width: 28,
                                      ))
                              ]),
                            ),
                            const SizedBox(height: 8),
                            Text(tasks[index].title,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(
                              tasks[index].time,
                              style: const TextStyle(
                                  fontSize: 13, color: Color(0xFF666666)),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              tasks[index].ml,
                              style: const TextStyle(
                                  fontSize: 13, color: Color(0xFF666666)),
                            )
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }

  Column topSlider() {
    return Column(
      children: [
        CarouselSlider(
          items: sliders.map((e) {
            return Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              color: MyColors.silverColor,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(e, fit: BoxFit.cover)),
            );
          }).toList(),
          options: CarouselOptions(
              aspectRatio: 2.08,
              autoPlay: true,
              onPageChanged: (idx, _) =>
                  {setState(() => _selectedSlider = idx)}),
        ),
        DotsIndicator(
            dotsCount: sliders.length,
            position: _selectedSlider.toDouble(),
            decorator: const DotsDecorator(
                color: MyColors.gray2, activeColor: MyColors.primaryColor)),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Image.asset(
        'assets/images/logo.png',
        height: 30,
        width: 30,
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/images/search.svg',
            color: Colors.black,
            width: 20,
            height: 20,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/images/scanner.svg',
            color: Colors.black,
            width: 20,
            height: 20,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/dscan');
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/images/notification.svg',
            color: Colors.black,
            width: 20,
            height: 20,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/images/cart.svg',
            color: Colors.black,
            width: 20,
            height: 20,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
