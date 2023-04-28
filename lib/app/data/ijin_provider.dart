// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:absensisbc/app/constant/api_const.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class IjinProvider extends GetConnect {
  Future<List<dynamic>> getLists(
    String token,
    String nip,
    String page,
  ) async {
    final response = await get(
        BASEAPI + 'pengajuan/ijin/lists?nip=' + nip + "&page=" + page,
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        });

    if (response.status.hasError) {
      return Future.error({'error': response.statusText});
    } else {
      return response.body['data'];
    }
  }

  Future<Map<String, dynamic>> postijin(
    String token,
    String nip,
    String tanggalMulai,
    String tanggalSelesai,
    String kodeIjin,
    String keterangan,
    String image,
  ) async {
    final body = {
      'nip': nip,
      'kode_ijin': kodeIjin,
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
      'keterangan': keterangan,
      'file': image,
    };

    var headers = {
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
    };
    var url = Uri.http(BASELINK, 'api/pengajuan/ijin/store');
    var response = await http.post(url, body: body, headers: headers);

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;
  }

  Future<Response> getMaster(String token) {
    return get('${BASEAPI}pengajuan/ijin', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }
}
