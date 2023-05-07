import 'package:get/get.dart';
import 'package:jamkerja/app/constant/api_const.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PresensiProvider extends GetConnect {
  var dataUser = GetStorage().read('dataUser');

  Future<Response> postPresensi(String nip, String token, String kordinat,
      String kodeShift, String kodeTingkat, String image) {
    final body = {
      'nip': nip,
      'kordinat': kordinat,
      'kode_tingkat': kodeTingkat,
      'kode_shift': kodeShift,
      'date': DateTime.now().toString(),
      'timezone': DateTime.now().toLocal().timeZoneName.toString(),
      'image': image,
    };

    return post('${BASEAPI}presensi/store', body, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<Map<String, dynamic>> postPresensiFree(
    String nip,
    String token,
    String kordinat,
    String image,
    String field,
  ) async {
    final body = {
      'nip': nip,
      'field': field,
      'kordinat': kordinat,
      'date': DateTime.now().toString(),
      'timezone': DateTime.now().toLocal().timeZoneName.toString(),
      'image': image,
    };

    var headers = {
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
    };
    var url = Uri.https(BASELINK, 'api/presensi/store_free');
    var response = await http.post(url, body: body, headers: headers);

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;

    // return await post('${BASEAPI}presensi/store_free', body, headers: {
    //   'Accept': 'application/json',
    //   'Authorization': "Bearer $token"
    // });
  }

  Future<List<dynamic>> getPresensi(
      String nip, String token, String start, String end) async {
    final response = await get(
        '${BASEAPI}presensi/laporan_free?nip=$nip&d=$start&e=$end',
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        });
    if (response.status.hasError) {
      return Future.error({'error': response.statusText});
    } else {
      return response.body;
    }
  }

  Future<List<dynamic>> getJamKerjaStatis() async {
    final response = await get(
        '${BASEAPI}presensi/jam_kerja_statis?nip=${dataUser['nip']}',
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer ${dataUser['access_token']}"
        });
    if (response.status.hasError) {
      return Future.error({'error': response.statusText});
    } else {
      return response.body;
    }
  }

  Future<List<dynamic>> getCalender(
    String bulan,
    String tahun,
  ) async {
    final response = await get(
        '${BASEAPI}presensi/jam_kerja_calender?nip=${dataUser['nip']}&bulan=$bulan&tahun=$tahun',
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer ${dataUser['access_token']}"
        });
    if (response.status.hasError) {
      return Future.error({'error': response.statusText});
    } else {
      return response.body;
    }
  }

  Future<List<dynamic>> getMasterJadwal() async {
    final response = await get('${BASEAPI}presensi/master_jam_kerja', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer ${dataUser['access_token']}"
    });
    if (response.status.hasError) {
      return Future.error({'error': response.statusText});
    } else {
      return response.body;
    }
  }

  Future<Response> getJamKerja() {
    return get('${BASEAPI}presensi/jam_kerja?nip=${dataUser['nip']}', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer ${dataUser['access_token']}"
    });
  }

  Future<Response> getShift(String token, String nip) {
    return get('${BASEAPI}presensi/shift?nip=$nip', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<Response> getRekap(String nip) {
    return get('${BASEAPI}presensi/rekap_bulan?nip=$nip', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer ${dataUser['access_token']}"
    });
  }

  Future<Response> getLokasi(String token, String nip) {
    return get('${BASEAPI}presensi/lokasi?nip=$nip', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<Response> getHariIni(String token, String nip) {
    return get('${BASEAPI}presensi?nip=$nip', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }
}
