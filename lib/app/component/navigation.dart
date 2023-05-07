import 'package:flutter/material.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({
    Key? key,
    required this.status,
    required this.icon,
    required this.title,
    required this.tap,
  }) : super(key: key);

  final bool status;
  final String title;
  final IconData icon;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 50,
            child: Icon(
              icon,
              size: 25,
              color: status == true ? Colors.blue[800] : Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: (status == true) ? Colors.blue[800] : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
