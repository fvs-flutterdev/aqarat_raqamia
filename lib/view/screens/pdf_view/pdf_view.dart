import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../../utils/text_style.dart';
import '../../base/lunch_widget.dart';

class PdfViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const PdfViewScreen({super.key, required this.url, required this.title});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreyColor,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
               launchUrlSocial( widget.url);
             // ur(widget.image[i]);
            },
            icon: Icon(Icons.download),
            color: goldColor,
          ),
        ],
      ),
      body: PDF().cachedFromUrl(
        widget.url,
        placeholder: (double progress) => Center(
          child: Text('$progress %'),
        ),
        errorWidget: (dynamic error) => Center(
          child: Text('${error.toString()}'),
        ),

      ),
    );
  }
}
