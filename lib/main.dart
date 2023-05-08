import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/widgets/splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/routes/app_pages.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("e286c21c-5f18-4464-bbc0-4a944b7ba371");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataUser = GetStorage().read('dataUser');

    Future<void> initOneSignal() async {
      await OneSignal.shared.setAppId("f704606c-6d70-4d3c-ac27-07bd10652d53");
      final status = await OneSignal.shared.getDeviceState();
      var playerId = status?.userId;
      final box = GetStorage();
      box.write('playerId', playerId);

      await Future.delayed(const Duration(seconds: 1));

    }

    // Dev Only
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "JamKerja.ID",
      initialRoute:
          dataUser == null ? Routes.AUTH_LOGIN : Routes.NAVIGATION_BOTTOM,
      getPages: AppPages.routes,
    );
    return FutureBuilder(
      future: initOneSignal(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "JamKerja.ID",
            initialRoute:
                dataUser == null ? Routes.AUTH_LOGIN : Routes.NAVIGATION_BOTTOM,
            getPages: AppPages.routes,
          );
        }
      },
    );
  }
}
