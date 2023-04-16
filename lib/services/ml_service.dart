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

class MlService {
  late final _apiLink;
  late final Dio _dio;
  late final _timeNow;
  MlService() {
    _apiLink = "http://10.20.62.6:8080";
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

  Future<ChatRoom> getChatMessages(String userId, String otherId) async {
    Response response = await _dio.get('/chat/room?uid=$userId&oid=$otherId');
    print(response.data);

    return ChatRoom.fromJson(response.data);
  }

  Future<void> sendMessage(String userId, String otherId, String text) async {
    final data = {"id": userId, "oid": otherId, "message": text};
    Response response = await _dio.post('/chat/message', data: data);
  }

  Future<DiseaseModel> predictDisease(String base64) async {
    Response response = await _dio.post('/app', data: {"image": base64});
    print(response.data);
    return DiseaseModel.fromJson(response.data);
  }
}
