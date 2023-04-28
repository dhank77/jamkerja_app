import 'package:flutter/material.dart';
import 'package:absensisbc/app/component/child/status.dart';

class CardMenu extends StatefulWidget {
  final String title, status, keterangan, color;
  final GestureTapCallback press;

  const CardMenu({
    Key? key,
    required this.title,
    required this.status,
    required this.keterangan,
    required this.press,
    this.color = "",
  }) : super(key: key);

  @override
  _CardMenuState createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 80,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.topStart,
                  color: widget.color == ""
                      ? Colors.grey[100]
                      : Color(int.parse(widget.color)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: widget.color == "" ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 230,
                        padding: EdgeInsets.only(left: 15),
                        height: double.infinity,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          widget.keterangan,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Status(
                              status: widget.status,
                              icon: true,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
