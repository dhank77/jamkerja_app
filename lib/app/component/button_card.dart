import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    Key? key,
    required this.judul,
    this.animate = false,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final bool animate;
  final String judul;
  final IconData icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: animate == false ? press : () {},
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        child: Container(
          width: 150,
          height: 100,
          color: Colors.amber[300],
          child: animate == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon),
                    Text(
                      judul,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
