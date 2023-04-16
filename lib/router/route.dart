import 'package:eppo/pages/chat_page.dart';
import 'dart:collection';
import 'package:eppo/pages/main_page.dart';
import 'package:eppo/pages/profile_screen.dart';
import 'package:eppo/screens/disease_detail_screen.dart';
import 'package:eppo/screens/ob_form_screen.dart';
import 'package:eppo/screens/ob_garden_name.dart';
import 'package:eppo/screens/ob_location_screen.dart';
import 'package:eppo/screens/plant_detail.dart';
import 'package:eppo/screens/plants_slot_screen.dart';
import 'package:eppo/screens/qr_type_screen.dart';
import 'package:eppo/screens/tasks_list_screen.dart';
import 'package:flutter/material.dart';
import '../pages/dr_screen.dart';
import '../pages/prof_page.dart';
import '../pages/sliver_detail.dart';
import '../screens/book_slot.dart';
import '../screens/disease_scan_screen.dart';
import '../screens/home_screen.dart';
import '../screens/qr_scanner.dart';
import '../screens/review_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => MainPage(),
  '/tasks': (p0) => TasksListScreen(),
  '/dscan': (p0) => DiseaseScanScreen(),
  '/ddetail': (p0) => DiseaseDetailScreen(),
  '/obform': (p0) => ObFormScreen(),
  '/obname': (p0) => ObGardenName(),
  '/oblocation': (p0) => ObLocationScreen(),
  '/qrtype': (p0) => QrTypeScreen(),
  '/qrscan': (p0) => QRViewExample(),
  '/plantdetail': (p0) => PlantDetailScreen(),
  '/slots': (p0) => PlantSlotScreen(),
};
