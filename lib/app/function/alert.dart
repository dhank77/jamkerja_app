import 'package:flutter/material.dart';
import 'package:get/get.dart';

void dialogError(String msg) {
  Get.defaultDialog(
    title: 'Terjadi Kesalahan',
    titleStyle: TextStyle(
      color: Colors.red[700],
      fontWeight: FontWeight.bold,
    ),
    middleText: msg,
    contentPadding: EdgeInsets.symmetric(horizontal: 13),
    cancel: ElevatedButton(
      onPressed: () => Get.back(),
      child: Text('OK'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFFD32F2F)),
      ),
    ),
  );
}

void dialogErrorBack(String msg, Function() fnc) {
  Get.defaultDialog(
   title: 'Terjadi Kesalahan',
    titleStyle: TextStyle(
      color: Colors.red[700],
      fontWeight: FontWeight.bold,
    ),
    middleText: msg,
    contentPadding: EdgeInsets.symmetric(horizontal: 13),
    cancel: ElevatedButton(
      onPressed: fnc,
      child: Text('OK'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF388E3C)),
      ),
    ),
  );
}
void dialogSuccess(String msg, Function() fnc) {
  Get.defaultDialog(
    title: 'Berhasil!',
    titleStyle: TextStyle(
      color: Colors.green[700],
      fontWeight: FontWeight.bold,
    ),
    middleText: msg,
    contentPadding: EdgeInsets.symmetric(horizontal: 13),
    cancel: ElevatedButton(
      onPressed: fnc,
      child: Text('OK'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF388E3C)),
      ),
    ),
  );
}

void dialogConfirm(String msg, Function() fnc) {
  Get.defaultDialog(
    title: 'Konfirmasi!',
    titleStyle: TextStyle(
      color: Colors.green[700],
      fontWeight: FontWeight.bold,
    ),
    middleText: msg,
    contentPadding: EdgeInsets.symmetric(horizontal: 13),
    cancel: ElevatedButton(
      onPressed: () => Get.back(),
      child: Text('Tidak'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFFD32F2F)),
      ),
    ),
    confirm: ElevatedButton(
      onPressed: fnc,
      child: Text('Ya'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF388E3C)),
      ),
    ),
  );
}
