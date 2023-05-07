import 'dart:convert';
import 'package:get/get.dart';
import 'package:jamkerja/app/constant/api_const.dart';

class UserProvider extends GetConnect {
  Future<Response> login(
    String username,
    String password,
    String imei,
    String playerId,
  ) {
    final data = json.encode({
      'email': username,
      'password': password,
      'imei': imei,
      'player_id': playerId,
    });
    return post('${BASEAPI}login', data,
        headers: {'Accept': 'application/json'});
  }

  Future<Response> getUser(String nip, String accessToken) {
    final data = json.encode({
      'nip': nip,
    });
    return post('${BASEAPI}getUser', data, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
  }

  Future<Response> logout(String nip, String accessToken) {
    final data = json.encode({'nip': nip});
    return post('${BASEAPI}logout', data, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
  }
}
