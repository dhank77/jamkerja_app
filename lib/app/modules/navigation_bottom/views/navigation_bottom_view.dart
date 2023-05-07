// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/modules/home/views/home_view.dart';
import 'package:jamkerja/app/modules/pengumuman/views/pengumuman_view.dart';
import 'package:jamkerja/app/modules/presensi_laporan/views/presensi_laporan_view.dart';
import 'package:jamkerja/app/modules/profil/views/profil_view.dart';

import '../controllers/navigation_bottom_controller.dart';

class NavigationBottomView extends StatelessWidget {
  const NavigationBottomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationBottomController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: [
              const HomeView(),
              const PengumumanView(),
              const PresensiLaporanView(),
              const ProfilView(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.amber[800],
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: Icons.home,
                label: 'Beranda',
              ),
              _bottomNavigationBarItem(
                icon: Icons.assignment_sharp,
                label: 'Pengumuman',
              ),
              _bottomNavigationBarItem(
                icon: Icons.location_history_rounded,
                label: 'Riwayat',
              ),
              _bottomNavigationBarItem(
                icon: Icons.person,
                label: 'Profil',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
