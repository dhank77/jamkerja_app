// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:jamkerja/app/constant/api_const.dart';
import 'package:get/get.dart';

class SakitProvider extends GetConnect {
  Future<List<dynamic>> getLists(
    String token,
    String nip,
    String page,
  ) async {
    final response = await get(
        BASEAPI + 'pengajuan/sakit/lists?nip=' + nip + "&page=" + page,
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

  // Future<Response> postSakit(
  //   String token,
  //   String nip,
  //   String tanggalMulai,
  //   String tanggalSelesai,
  //   String keterangan,
  //   String baseimage,
  // ) {
  //   final body = {
  //     'nip': nip,
  //     'tanggal_mulai': tanggalMulai,
  //     'tanggal_selesai': tanggalSelesai,
  //     'keterangan': keterangan,
  //     'file': baseimage,
  //   };

  //   return post('${BASEAPI}pengajuan/sakit/store', body, headers: {
  //     'Accept': 'application/json',
  //     'Authorization': "Bearer $token"
  //   });
  // }

  Future<Map<String, dynamic>> postSakit(
    String token,
    String nip,
    String tanggalMulai,
    String tanggalSelesai,
    String keterangan,
    String image,
  ) async {
    final body = {
      'nip': nip,
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
      'keterangan': keterangan,
      'file': image,
    };

    var headers = {
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
    };
    var url = Uri.http(BASELINK, 'api/pengajuan/sakit/store');
    var response = await http.post(url, body: body, headers: headers);

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;
  }
}
