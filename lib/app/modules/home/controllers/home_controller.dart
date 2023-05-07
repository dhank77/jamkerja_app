import 'package:flutter/material.dart';
import 'package:jamkerja/app/component/item_kategori.dart';
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
          'kode_perusahaan': data['kode_perusahaan'].toString(),
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

  void modalBottomSheetMenu() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (builder) {
        return Container(
          height: 450.0,
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    "Menu Utama",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ItemKategori(
                        title: "Presensi",
                        color: const Color(0xff5369f8),
                        icon: Icons.location_on,
                        tap: () => Get.toNamed(
                          Routes.PRESENSI_FREE,
                        ),
                      ),
                      ItemKategori(
                        title: "Kunjungan",
                        color: const Color(0xffec1d27),
                        icon: Icons.share_location_sharp,
                        tap: () => Get.toNamed(
                          Routes.MENU_VISIT,
                        ),
                      ),
                      ItemKategori(
                        title: "Lembur",
                        color: const Color(0xff0b945e),
                        icon: Icons.timelapse_sharp,
                        tap: () => Get.toNamed(
                          Routes.MENU_LEMBUR,
                        ),
                      ),
                      ItemKategori(
                        title: "Jam Kerja",
                        color: const Color(0xff72d2a2),
                        icon: Icons.lock_clock,
                        tap: () => Get.toNamed(Routes.JAM_KERJA),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      ItemKategori(
                        title: "Cuti",
                        color: const Color(0xff68a9e3),
                        icon: Icons.timer_sharp,
                        tap: () => Get.toNamed(
                          Routes.MENU_CUTI,
                        ),
                      ),
                      ItemKategori(
                        title: "Sakit",
                        color: Colors.lightBlueAccent,
                        icon: Icons.sticky_note_2,
                        tap: () => Get.toNamed(
                          Routes.MENU_SAKIT,
                        ),
                      ),
                       ItemKategori(
                        title: "Perusahaan",
                        color: const Color(0xff8dc53e),
                        icon: Icons.corporate_fare,
                        tap: () => Get.toNamed(
                          Routes.MENU_PERUSAHAAN,
                        ),
                      ),
                      ItemKategori(
                        title: "Ijin",
                        color: const Color(0xffF4BB44),
                        icon: Icons.system_security_update_warning_sharp,
                        tap: () => Get.toNamed(Routes.MENU_IJIN),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ItemKategori(
                        title: "Izin",
                        color: const Color(0xff72d2a2),
                        icon: Icons.note_alt_sharp,
                        tap: () => Get.toNamed(Routes.MENU_IZIN),
                      ),
                      ItemKategori(
                        title: "Reimbur\nsement",
                        color: const Color(0xff14639e),
                        icon: Icons.receipt_long_outlined,
                        tap: () => Get.toNamed(
                          Routes.MENU_REIMBURSEMENT,
                        ),
                      ),
                      ItemKategori(
                        title: "Payslip",
                        color: Colors.blue,
                        icon: Icons.library_books_outlined,
                        tap: () => Get.toNamed(Routes.MENU_PAYSLIP),
                      ),
                      const SizedBox(width: 60),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
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
