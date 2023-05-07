import 'package:jamkerja/app/data/sakit_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuSakitController extends GetxController {
  var listData = List<dynamic>.empty(growable: true).obs;
  String dateToday = DateTime.now().toString().substring(0, 10);
  int page = 1;
  var isDataProcessing = false.obs;
  var dataUser = GetStorage().read('dataUser');

  // For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  void getData() {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);
      SakitProvider()
          .getLists(
        dataUser['access_token'],
        dataUser['nip'],
        page.toString(),
      )
          .then((resp) {
        print(resp);
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
      SakitProvider()
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

  @override
  void onInit() {
    super.onInit();
    getData();
    paginate();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
