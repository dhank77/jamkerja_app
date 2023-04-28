import 'package:absensisbc/app/component/app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_login_controller.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: ClipPathClass(),
            child: Container(
              height: 250,
              width: Get.width,
              color: Colors.amber[100],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/logo.png"),
                ),
                const Text(
                  ' ABSENSI SBC',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "No Pegawai / Email",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Masukkan No Pegawai / Email",
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextField(
                    controller: controller.password,
                    keyboardType: TextInputType.text,
                    obscureText: controller.hide.value,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Masukkan Password",
                      suffixIcon: IconButton(
                        onPressed: () => controller.hide.toggle(),
                        icon: Icon(Icons.remove_red_eye,
                            color: controller.hide.isTrue
                                ? Colors.black45
                                : Colors.amber),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Saya menyetujui ",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("klik syarat");
                              },
                            text: "syarat",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          const TextSpan(
                            text: ", ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("klik ketentuan");
                              },
                            text: "ketentuan",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          const TextSpan(
                            text: " dan ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("klik privasi");
                              },
                            text: "privasi",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () =>
                      controller.animate.isFalse ? controller.login() : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber[300],
                    fixedSize: const Size(150, 50),
                  ),
                  child: Obx(
                    () => controller.animate.isTrue
                        ? const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            "MASUK",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
