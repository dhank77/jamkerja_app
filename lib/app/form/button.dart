import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function()? fnc;
  final bool animate;
  final double width;
  final Color color;

  const Button({
    Key? key,
    required this.fnc,
    this.label = "Simpan",
    this.animate = false,
    this.width = 200,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fnc,
      style: ElevatedButton.styleFrom(
        onPrimary: color,
        shadowColor: color,
        elevation: 5,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: width,
          height: 50,
          alignment: Alignment.center,
          child: animate == false
              ? Text(
                  label,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                )
              : CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
