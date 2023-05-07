import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamkerja/app/component/navigation.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

class NavBarBor extends StatelessWidget {
  const NavBarBor({
    Key? key,
    required this.aktif,
  }) : super(key: key);

  final String aktif;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      height: 80,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      // color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavigationPage(
            tap: () => aktif == 'beranda' ? {} : Get.offAllNamed(Routes.HOME),
            icon: Icons.home,
            status: aktif == 'beranda' ? true : false,
            title: "Beranda",
          ),
          NavigationPage(
            tap: () =>
                aktif == 'pengumuman' ? {} : Get.offAllNamed(Routes.PENGUMUMAN),
            icon: Icons.message,
            status: aktif == 'pengumuman' ? true : false,
            title: "Pengumuman",
          ),
          NavigationPage(
            tap: () => aktif == 'riwayat'
                ? {}
                : Get.offAllNamed(Routes.PRESENSI_LAPORAN),
            icon: Icons.location_history_rounded,
            status: aktif == 'riwayat' ? true : false,
            title: "Riwayat",
          ),
          NavigationPage(
            tap: () => aktif == 'profil' ? {} : Get.offAllNamed(Routes.PROFIL),
            icon: Icons.person,
            status: aktif == 'profil' ? true : false,
            title: "Profil",
          ),
        ],
      ),
    );
  }
}
