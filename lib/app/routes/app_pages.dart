import 'package:get/get.dart';

import '../modules/auth_login/bindings/auth_login_binding.dart';
import '../modules/auth_login/views/auth_login_view.dart';
import '../modules/camera_front/bindings/camera_front_binding.dart';
import '../modules/camera_front/views/camera_front_view.dart';
import '../modules/cuti_add/bindings/cuti_add_binding.dart';
import '../modules/cuti_add/views/cuti_add_view.dart';
import '../modules/cuti_detail/bindings/cuti_detail_binding.dart';
import '../modules/cuti_detail/views/cuti_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/ijin_add/bindings/ijin_add_binding.dart';
import '../modules/ijin_add/views/ijin_add_view.dart';
import '../modules/ijin_detail/bindings/ijin_detail_binding.dart';
import '../modules/ijin_detail/views/ijin_detail_view.dart';
import '../modules/izin_add/bindings/izin_add_binding.dart';
import '../modules/izin_add/views/izin_add_view.dart';
import '../modules/izin_detail/bindings/izin_detail_binding.dart';
import '../modules/izin_detail/views/izin_detail_view.dart';
import '../modules/jam_kerja/bindings/jam_kerja_binding.dart';
import '../modules/jam_kerja/views/jam_kerja_view.dart';
import '../modules/lembur_add/bindings/lembur_add_binding.dart';
import '../modules/lembur_add/views/lembur_add_view.dart';
import '../modules/lembur_detail/bindings/lembur_detail_binding.dart';
import '../modules/lembur_detail/views/lembur_detail_view.dart';
import '../modules/menu_cuti/bindings/menu_cuti_binding.dart';
import '../modules/menu_cuti/views/menu_cuti_view.dart';
import '../modules/menu_ijin/bindings/menu_ijin_binding.dart';
import '../modules/menu_ijin/views/menu_ijin_view.dart';
import '../modules/menu_izin/bindings/menu_izin_binding.dart';
import '../modules/menu_izin/views/menu_izin_view.dart';
import '../modules/menu_lembur/bindings/menu_lembur_binding.dart';
import '../modules/menu_lembur/views/menu_lembur_view.dart';
import '../modules/menu_payslip/bindings/menu_payslip_binding.dart';
import '../modules/menu_payslip/views/menu_payslip_view.dart';
import '../modules/menu_perusahaan/bindings/menu_perusahaan_binding.dart';
import '../modules/menu_perusahaan/views/menu_perusahaan_view.dart';
import '../modules/menu_presensi/bindings/menu_presensi_binding.dart';
import '../modules/menu_presensi/views/menu_presensi_view.dart';
import '../modules/menu_reimbursement/bindings/menu_reimbursement_binding.dart';
import '../modules/menu_reimbursement/views/menu_reimbursement_view.dart';
import '../modules/menu_sakit/bindings/menu_sakit_binding.dart';
import '../modules/menu_sakit/views/menu_sakit_view.dart';
import '../modules/menu_shift/bindings/menu_shift_binding.dart';
import '../modules/menu_shift/views/menu_shift_view.dart';
import '../modules/menu_visit/bindings/menu_visit_binding.dart';
import '../modules/menu_visit/views/menu_visit_view.dart';
import '../modules/navigation_bottom/bindings/navigation_bottom_binding.dart';
import '../modules/navigation_bottom/views/navigation_bottom_view.dart';
import '../modules/payslip_detail/bindings/payslip_detail_binding.dart';
import '../modules/payslip_detail/views/payslip_detail_view.dart';
import '../modules/pengumuman/bindings/pengumuman_binding.dart';
import '../modules/pengumuman/views/pengumuman_view.dart';
import '../modules/pengumuman_detail/bindings/pengumuman_detail_binding.dart';
import '../modules/pengumuman_detail/views/pengumuman_detail_view.dart';
import '../modules/presensi_free/bindings/presensi_free_binding.dart';
import '../modules/presensi_free/views/presensi_free_view.dart';
import '../modules/presensi_laporan/bindings/presensi_laporan_binding.dart';
import '../modules/presensi_laporan/views/presensi_laporan_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/reimbursement_add/bindings/reimbursement_add_binding.dart';
import '../modules/reimbursement_add/views/reimbursement_add_view.dart';
import '../modules/reimbursement_detail/bindings/reimbursement_detail_binding.dart';
import '../modules/reimbursement_detail/views/reimbursement_detail_view.dart';
import '../modules/sakit_add/bindings/sakit_add_binding.dart';
import '../modules/sakit_add/views/sakit_add_view.dart';
import '../modules/sakit_detail/bindings/sakit_detail_binding.dart';
import '../modules/sakit_detail/views/sakit_detail_view.dart';
import '../modules/shift_add/bindings/shift_add_binding.dart';
import '../modules/shift_add/views/shift_add_view.dart';
import '../modules/shift_detail/bindings/shift_detail_binding.dart';
import '../modules/shift_detail/views/shift_detail_view.dart';
import '../modules/visit_add/bindings/visit_add_binding.dart';
import '../modules/visit_add/views/visit_add_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH_LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_LOGIN,
      page: () => const AuthLoginView(),
      binding: AuthLoginBinding(),
    ),
    GetPage(
      name: _Paths.MENU_PRESENSI,
      page: () => const MenuPresensiView(),
      binding: MenuPresensiBinding(),
    ),
    GetPage(
      name: _Paths.MENU_CUTI,
      page: () => const MenuCutiView(),
      binding: MenuCutiBinding(),
    ),
    GetPage(
      name: _Paths.CUTI_ADD,
      page: () => const CutiAddView(),
      binding: CutiAddBinding(),
    ),
    GetPage(
      name: _Paths.CUTI_DETAIL,
      page: () => const CutiDetailView(),
      binding: CutiDetailBinding(),
    ),
    GetPage(
      name: _Paths.LEMBUR_ADD,
      page: () => const LemburAddView(),
      binding: LemburAddBinding(),
    ),
    GetPage(
      name: _Paths.LEMBUR_DETAIL,
      page: () => const LemburDetailView(),
      binding: LemburDetailBinding(),
    ),
    GetPage(
      name: _Paths.MENU_LEMBUR,
      page: () => const MenuLemburView(),
      binding: MenuLemburBinding(),
    ),
    GetPage(
      name: _Paths.MENU_REIMBURSEMENT,
      page: () => const MenuReimbursementView(),
      binding: MenuReimbursementBinding(),
    ),
    GetPage(
      name: _Paths.REIMBURSEMENT_ADD,
      page: () => const ReimbursementAddView(),
      binding: ReimbursementAddBinding(),
    ),
    GetPage(
      name: _Paths.REIMBURSEMENT_DETAIL,
      page: () => const ReimbursementDetailView(),
      binding: ReimbursementDetailBinding(),
    ),
    GetPage(
      name: _Paths.MENU_PAYSLIP,
      page: () => const MenuPayslipView(),
      binding: MenuPayslipBinding(),
    ),
    GetPage(
      name: _Paths.PAYSLIP_DETAIL,
      page: () => const PayslipDetailView(),
      binding: PayslipDetailBinding(),
    ),
    GetPage(
      name: _Paths.MENU_SHIFT,
      page: () => const MenuShiftView(),
      binding: MenuShiftBinding(),
    ),
    GetPage(
      name: _Paths.SHIFT_DETAIL,
      page: () => const ShiftDetailView(),
      binding: ShiftDetailBinding(),
    ),
    GetPage(
      name: _Paths.SHIFT_ADD,
      page: () => const ShiftAddView(),
      binding: ShiftAddBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.PENGUMUMAN,
      page: () => const PengumumanView(),
      binding: PengumumanBinding(),
    ),
    GetPage(
      name: _Paths.PENGUMUMAN_DETAIL,
      page: () => const PengumumanDetailView(),
      binding: PengumumanDetailBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI_LAPORAN,
      page: () => const PresensiLaporanView(),
      binding: PresensiLaporanBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_BOTTOM,
      page: () => const NavigationBottomView(),
      binding: NavigationBottomBinding(),
    ),
    GetPage(
      name: _Paths.MENU_PERUSAHAAN,
      page: () => const MenuPerusahaanView(),
      binding: MenuPerusahaanBinding(),
    ),
    GetPage(
      name: _Paths.MENU_VISIT,
      page: () => const MenuVisitView(),
      binding: MenuVisitBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI_FREE,
      page: () => const PresensiFreeView(),
      binding: PresensiFreeBinding(),
    ),
    GetPage(
      name: _Paths.JAM_KERJA,
      page: () => const JamKerjaView(),
      binding: JamKerjaBinding(),
    ),
    GetPage(
      name: _Paths.MENU_SAKIT,
      page: () => const MenuSakitView(),
      binding: MenuSakitBinding(),
    ),
    GetPage(
      name: _Paths.SAKIT_ADD,
      page: () => const SakitAddView(),
      binding: SakitAddBinding(),
    ),
    GetPage(
      name: _Paths.SAKIT_DETAIL,
      page: () => const SakitDetailView(),
      binding: SakitDetailBinding(),
    ),
    GetPage(
      name: _Paths.MENU_IZIN,
      page: () => const MenuIzinView(),
      binding: MenuIzinBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_ADD,
      page: () => const IzinAddView(),
      binding: IzinAddBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_DETAIL,
      page: () => const IzinDetailView(),
      binding: IzinDetailBinding(),
    ),
    GetPage(
      name: _Paths.MENU_IJIN,
      page: () => const MenuIjinView(),
      binding: MenuIjinBinding(),
    ),
    GetPage(
      name: _Paths.IJIN_ADD,
      page: () => const IjinAddView(),
      binding: IjinAddBinding(),
    ),
    GetPage(
      name: _Paths.IJIN_DETAIL,
      page: () => const IjinDetailView(),
      binding: IjinDetailBinding(),
    ),
    GetPage(
      name: _Paths.VISIT_ADD,
      page: () => const VisitAddView(),
      binding: VisitAddBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA_FRONT,
      page: () => const CameraFrontView(),
      binding: CameraFrontBinding(),
    ),
  ];
}
