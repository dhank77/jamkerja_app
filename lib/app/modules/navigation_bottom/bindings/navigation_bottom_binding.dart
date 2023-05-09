import 'package:get/get.dart';
import 'package:jamkerja/app/modules/home/controllers/home_controller.dart';
import 'package:jamkerja/app/modules/menu_payslip/controllers/menu_payslip_controller.dart';
import 'package:jamkerja/app/modules/pengumuman/controllers/pengumuman_controller.dart';
import 'package:jamkerja/app/modules/presensi_free/controllers/presensi_free_controller.dart';
import 'package:jamkerja/app/modules/presensi_laporan/controllers/presensi_laporan_controller.dart';
import 'package:jamkerja/app/modules/profil/controllers/profil_controller.dart';

import '../controllers/navigation_bottom_controller.dart';

class NavigationBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationBottomController>(
      () => NavigationBottomController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<PengumumanController>(
      () => PengumumanController(),
    );
    Get.lazyPut<PresensiLaporanController>(
      () => PresensiLaporanController(),
    );
    Get.lazyPut<ProfilController>(
      () => ProfilController(),
    );
    Get.lazyPut<PresensiFreeController>(
      () => PresensiFreeController(),
    );
    Get.lazyPut<MenuPayslipController>( 
      () => MenuPayslipController(),
    );
  }
}
