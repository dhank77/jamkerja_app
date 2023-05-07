import 'package:flutter/material.dart';

class FormSelect extends StatelessWidget {
  final String initialValue;
  final String label;
  final List<DropdownMenuItem<Object>> listData;
  final Function(Object?) onChanged;
  final IconData icon;

  const FormSelect({
    Key? key,
    required this.initialValue,
    required this.listData,
    required this.onChanged,
    required this.label,
    this.icon = Icons.home_work,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 0.2),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(1, 1)),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: DropdownButton(
              isExpanded: true,
              underline: SizedBox(),
              hint: Text(label),
              value: initialValue,
              items: listData,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
