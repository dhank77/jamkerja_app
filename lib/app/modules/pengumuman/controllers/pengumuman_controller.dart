import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:absensisbc/app/data/pengumuman_provider.dart';

class PengumumanController extends GetxController {
  var listPengumuman = List<dynamic>.empty(growable: true).obs;
  String dateToday = DateTime.now().toString().substring(0, 10);
  int page = 1;
  var isDataProcessing = false.obs;
  var dataUser = GetStorage().read('dataUser');

  // For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  void getPengumuman() {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);
      PengumumanProvider()
          .getLists(dataUser['access_token'], page.toString())
          .then((resp) {
        isDataProcessing(false);
        listPengumuman.addAll(resp);
      }, onError: (err) {
        isDataProcessing(false);
      });
    } catch (exception) {
      isDataProcessing(false);
    }
  }

  // For Pagination
  void paginate() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        getMorePengumuman();
      }
    });
  }

  // Get More data
  void getMorePengumuman() {
    try {
      PengumumanProvider()
          .getLists(dataUser['access_token'], page.toString())
          .then((resp) {
        if (resp.isNotEmpty) {
          isMoreDataAvailable(true);
        } else {
          isMoreDataAvailable(false);
        }
        listPengumuman.addAll(resp);
      }, onError: (err) {
        isMoreDataAvailable(false);
      });
    } catch (exception) {
      isMoreDataAvailable(false);
    }
  }

  // Refresh List
  void refreshList() async {
    page = 1;
    getPengumuman();
  }

  @override
  void onInit() {
    super.onInit();
    getPengumuman();
    paginate();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
