import 'package:jamkerja/app/data/presensi_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/data/pengumuman_provider.dart';
import 'package:jamkerja/app/data/providers/user_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  var listPengumuman = List<dynamic>.empty(growable: true).obs;
  var dataUser = GetStorage().read('dataUser');
  var kehadiran = {}.obs;

  void logout() {
    try {
      UserProvider()
          .logout(dataUser['nip'], dataUser['access_token'])
          .then((value) {
        box.remove('dataUser');
        Get.offAllNamed(Routes.AUTH_LOGIN);
      });
    } catch (e) {
      print(e);
      dialogError('Pastikan Koneksi Internet Anda Baik!');
    }
  }

  Future<void> getUser() async {
    try {
      await UserProvider()
          .getUser(dataUser['nip'], dataUser['access_token'])
          .then((value) {
        final data = value.body;
        box.write('dataUser', {
          'name': data['name'].toString(),
          'nip': data['nip'].toString(),
          'no_hp': data['no_hp'].toString(),
          'email': data['email'].toString(),
          'jabatan': data['nama_jabatan'].toString(),
          'skpd': data['skpd'].toString(),
          'images': data['images'].toString(),
          'access_token': dataUser['access_token'].toString(),
        });
        dataUser = box.read('dataUser');
      });
    } catch (e) {
      print(e);
      dialogError('Pastikan Koneksi Internet Anda Baik!');
    }
  }

  void getPengumuman() {
    try {
      PengumumanProvider().getLists(dataUser['access_token'], '1').then((resp) {
        listPengumuman.addAll(resp);
      }, onError: (err) {
        print(err);
      });
    } catch (exception) {
      print(exception);
    }
  }

  void getRekap() {
    try {
      PresensiProvider().getRekap(dataUser['nip']).then((resp) {
        kehadiran.addAll(resp.body);
      }, onError: (err) {
        print(err);
      });
    } catch (exception) {
      print(exception);
    }
  }

  @override
  void onInit() {
    getUser();
    getPengumuman();
    getRekap();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
