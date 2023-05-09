// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/modules/home/views/home_view.dart';
import 'package:jamkerja/app/modules/menu_payslip/views/menu_payslip_view.dart';
import 'package:jamkerja/app/modules/pengumuman/views/pengumuman_view.dart';
import 'package:jamkerja/app/modules/presensi_free/views/presensi_free_view.dart';
import 'package:jamkerja/app/modules/presensi_laporan/views/presensi_laporan_view.dart';
import 'package:jamkerja/app/modules/profil/views/profil_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../controllers/navigation_bottom_controller.dart';

class NavigationBottomView extends GetView<NavigationBottomController>  {
  const NavigationBottomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.persisten,
      screens: const [
        HomeView(),
        PengumumanView(),
        PresensiFreeView(),
        MenuPayslipView(),
        ProfilView(),
      ],
      items: _navBarsItems(),
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      padding: const NavBarPadding.all(5),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.announcement),
      title: ("Pengumuman"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.location_on_rounded,
        color: Colors.white,
      ),
      title: ("Presensi"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.monetization_on),
      title: ("Slip Gaji"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_sharp),
      title: ("Profil"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}
