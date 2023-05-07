import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  const Status({
    Key? key,
    required this.status,
    this.icon = false,
  }) : super(key: key);

  final String status;
  final bool icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon == true
            ? (status.toUpperCase() == 'DIAJUKAN')
                ? Icon(
                    Icons.arrow_drop_down_circle_rounded,
                    color: Colors.blueAccent,
                  )
                : (status.toUpperCase() == 'DITERIMA' ||
                        status.toUpperCase() == 'AKTIF')
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green[300],
                      )
                    : Icon(
                        Icons.cancel,
                        color: Colors.red[400],
                      )
            : SizedBox(),
        Text(
          status.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: status.toUpperCase() == 'DIAJUKAN'
                ? Colors.blueAccent[700]
                : (status.toUpperCase() == 'DITERIMA' ||
                        status.toUpperCase() == 'AKTIF'
                    ? Colors.green[300]
                    : Colors.red[400]),
          ),
        ),
      ],
    );
  }
}
