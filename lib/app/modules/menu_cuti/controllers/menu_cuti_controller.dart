import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/data/cuti_provider.dart';

class MenuCutiController extends GetxController {
  var listData = List<dynamic>.empty(growable: true).obs;
  String dateToday = DateTime.now().toString().substring(0, 10);
  int page = 1;
  var isDataProcessing = false.obs;
  var dataUser = GetStorage().read('dataUser');
  var cuti = {}.obs;

  // For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  void getData() {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);
      CutiProvider()
          .getLists(dataUser['access_token'], dataUser['nip'], page.toString())
          .then((resp) {
        isDataProcessing(false);
        listData.addAll(resp);
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
        getMoreData();
      }
    });
  }

  // Get More data
  void getMoreData() {
    try {
      CutiProvider()
          .getLists(dataUser['access_token'], dataUser['nip'], page.toString())
          .then((resp) {
        if (resp.isNotEmpty) {
          isMoreDataAvailable(true);
        } else {
          isMoreDataAvailable(false);
        }
        listData.addAll(resp);
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
    getData();
  }

  void getRekap() {
    try {
      CutiProvider().getRekap(dataUser['nip']).then((resp) {
        cuti.addAll(resp.body);
        print(cuti);
      }, onError: (err) {
        print(err);
      });
    } catch (exception) {
      print(exception);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    getRekap();
    paginate();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
