import 'package:flutter/material.dart';

class CardStats extends StatelessWidget {
  const CardStats({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final String title, value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Card(
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  icon,
                  size: 40,
                  color: Colors.amber,
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.right,
                ),
                subtitle: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
