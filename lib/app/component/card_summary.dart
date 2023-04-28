import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  const CardSummary({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    this.width = 115,
    this.fontSize = 12,
  }) : super(key: key);

  final String title, value;
  final Color color;
  final IconData icon;
  final double width, fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  icon,
                  size: 24,
                  color: color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          Container(
            width: width,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: (color).withOpacity(0.85),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: fontSize,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
