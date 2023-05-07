import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamkerja/app/constant/api_const.dart';
import 'package:path/path.dart' as path;

class BannerPage extends StatelessWidget {
  const BannerPage({
    Key? key,
    required this.image,
    required this.tap,
  }) : super(key: key);

  final String image;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        width: Get.width * 0.7,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: path.extension(image) == '.pdf'
                ? NetworkImage("${BASEURL}pdf.jpg")
                : NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
