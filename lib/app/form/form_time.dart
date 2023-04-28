import 'package:flutter/material.dart';

class FormTime extends StatelessWidget {
  final TextEditingController control;
  final String title;
  final IconData icon;
  final Function() tap;

  const FormTime({
    Key? key,
    required this.control,
    required this.title,
    required this.icon,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 0.2),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(1, 1)),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: control,
                readOnly: true,
                onTap: tap,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 54, 27, 6),
                  ),
                  labelText: title,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
