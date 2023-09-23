import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eppo/models/disease_model.dart';
// import 'package:eppo/models/get_slots_response.dart';
import 'package:intl/intl.dart';

// import '../models/chat_room.dart';
import 'package:eppo/models/get_booked_slot_response.dart';
import 'package:eppo/models/get_slots_response.dart';
import 'package:eppo/models/order.dart';
import 'package:intl/intl.dart';

import '../models/chat_room.dart';

class MailService {
  late final _apiLink;
  late final Dio _dio;
  late final _timeNow;
  MailService() {
    _apiLink = "http://10.53.21.182:900";
    _dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
        },
        baseUrl: _apiLink,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 200) < 500;
        },
      ),
    );
    _timeNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }
  Future<void> sendQr() async {
    Response response = await _dio.get('/send');
    print(response.data);
  }
}
