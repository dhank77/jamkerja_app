import 'package:flutter/material.dart';

class ListProfile extends StatelessWidget {
  const ListProfile({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final String title, value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(value),
              ],
            ),
          )
        ],
      ),
    );
  }
}
