import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:absensisbc/app/constant/api_const.dart';
import 'package:path/path.dart' as path;

class CardPengumuman extends StatefulWidget {
  final String imageUrl, title;
  final GestureTapCallback press;
  final bool now;

  const CardPengumuman({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.press,
    this.now = false,
  }) : super(key: key);

  @override
  _CardPengumumanState createState() => _CardPengumumanState();
}

class _CardPengumumanState extends State<CardPengumuman> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 200,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: path.extension(widget.imageUrl) == '.pdf'
                            ? BASEURL + 'pdf.jpg'
                            : (widget.imageUrl == ''
                                ? BASEURL + 'no-file.png'
                                : widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    widget.now
                        ? Positioned(
                            child: Container(
                              color: Colors.red[400],
                              height: 30,
                              width: 50,
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                'Baru',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            bottom: 0,
                          )
                        : SizedBox(),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
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
