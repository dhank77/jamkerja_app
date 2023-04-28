import 'package:flutter/material.dart';

class ItemKategori extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final GestureTapCallback tap;

  ItemKategori({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.tap,
  }) : super(key: key);

  @override
  State<ItemKategori> createState() => _ItemKategoriState();
}

class _ItemKategoriState extends State<ItemKategori> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.05),
            ),
            child: Icon(
              widget.icon,
              color: widget.color,
              size: 35,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
