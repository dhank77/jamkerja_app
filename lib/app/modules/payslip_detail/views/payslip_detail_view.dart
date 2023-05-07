import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/component/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/payslip_detail_controller.dart';

class PayslipDetailView extends GetView<PayslipDetailController> {
  const PayslipDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Stack(
        children: [
          Text(
            controller.data['slip_drive'].toString(),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
          controller.data != ""
              ? WebView(
                  initialUrl: controller.data['slip_drive'].toString(),
                  javascriptMode: JavascriptMode.unrestricted,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
