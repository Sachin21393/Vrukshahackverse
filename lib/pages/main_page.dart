import 'dart:convert';

import 'package:eppo/constants/colors.dart';
import 'package:eppo/pages/chat_page.dart';
import 'package:eppo/pages/home_page.dart';
import 'package:eppo/pages/on_appointment.dart';
import 'package:eppo/screens/home_screen_new.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:eppo/pages/profile_screen.dart';
import 'package:eppo/pages/schedule.dart';
import 'package:eppo/services/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../firebase_notification_provider.dart';

import 'dr_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // current index state
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    initMessaging();
    _currentIndex = 0;
    // NotificationListenerProvider().getMessage(context);

    initMessaging();
    sendPushToken();
  }

  void initMessaging() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin fltNotification =
        FlutterLocalNotificationsPlugin();
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit);

    fltNotification.initialize(initSetting);
    var androidDetails =
        const AndroidNotificationDetails("default", "channel name");
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }

  sendPushToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print(token);
      await ApiService().sendFcmToken(token, '64157b99303ac48fb69cd12e');
    } else
      print('token is null');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.gray3,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeScreenNew(),
            Center(
              child: SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [Image.asset('assets/images/shop.png')],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [Image.asset('assets/images/community.png')],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [Image.asset('assets/images/profile.png')],
                    ),
                  ),
                ),
              ),
            ),
          ],
          onPageChanged: (idx) {
            setState(() {
              _currentIndex = idx;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/slots');
          },
          backgroundColor: MyColors.primaryColor,
          child: SvgPicture.asset('assets/images/fab.svg'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MyColors.white,
          unselectedItemColor: MyColors.onPrimaryColor,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              _pageController
                  .jumpTo(_currentIndex * MediaQuery.of(context).size.width);
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: MyColors.primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/nav1.svg',
                color: _currentIndex == 0
                    ? MyColors.primaryColor
                    : MyColors.onPrimaryColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/nav2.svg',
                color: _currentIndex == 1
                    ? MyColors.primaryColor
                    : MyColors.onPrimaryColor,
              ),
              label: 'Shop',
            ),
            // BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/nav3.svg',
                color: _currentIndex == 2
                    ? MyColors.primaryColor
                    : MyColors.onPrimaryColor,
              ),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/nav4.svg',
                color: _currentIndex == 3
                    ? MyColors.primaryColor
                    : MyColors.onPrimaryColor,
              ),
              label: 'Profile',
            ),
          ],
          // ),
        ));
  }
}
