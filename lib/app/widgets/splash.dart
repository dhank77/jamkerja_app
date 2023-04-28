import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/logo.png"),
              ),
              // Text(
              //   "HR SISTEM",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.amber[800],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: Colors.amber[800],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
