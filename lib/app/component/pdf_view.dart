import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:absensisbc/app/component/app_bar.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfPage extends StatelessWidget {
  final String file;
  const PdfPage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Center(
        child: Container(
          child: FutureBuilder<File>(
            future: DefaultCacheManager().getSingleFile(file),
            builder: (context, snapshot) => snapshot.hasData
                ? PdfViewer.openFile(snapshot.data!.path)
                : const CircularProgressIndicator(
                    color: Colors.green,
                  ),
          ),
        ),
      ),
    );
  }
}
