import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationBottomController extends GetxController {
   late PersistentTabController persisten;

  @override
  void onInit() {
    persisten = PersistentTabController(initialIndex: 0);
    super.onInit();
  }
  
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
