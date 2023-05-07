import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  const AppBarCustom({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber[600],
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Image.asset("assets/images/logo.png"),
          ),
          const Text(
            ' JamKerja.ID',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
}
