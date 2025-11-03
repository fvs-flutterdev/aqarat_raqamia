// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//
// class PDFThumbnailWidget extends StatefulWidget {
//   final String pdfUrl;
//
//   const PDFThumbnailWidget({Key? key, required this.pdfUrl}) : super(key: key);
//
//   @override
//   _PDFThumbnailWidgetState createState() => _PDFThumbnailWidgetState();
// }
//
// class _PDFThumbnailWidgetState extends State<PDFThumbnailWidget> {
//   String? localPath;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadPdf();
//   }
//
//   Future<void> loadPdf() async {
//     final file = await DefaultCacheManager().getSingleFile(widget.pdfUrl);
//     setState(() {
//       localPath = file.path;
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(child: CircularProgressIndicator())
//         : Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: PDFView(
//
//           filePath: localPath,
//           defaultPage: 0, // Show the first page
//           enableSwipe: false,
//           swipeHorizontal: false,
//           autoSpacing: false,
//           pageFling: false,
//           onRender: (_pages) {
//             // PDF is rendered
//           },
//           onError: (error) {
//             print(error.toString());
//           },
//           onPageError: (page, error) {
//             print('$page: ${error.toString()}');
//           },
//           onPageChanged: (int? page, int? total) {
//             print('page change: $page/$total');
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../utils/dimention.dart';

class PDFThumbnailWidget extends StatefulWidget {
  final String pdfUrl;

  const PDFThumbnailWidget({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _PDFThumbnailWidgetState createState() => _PDFThumbnailWidgetState();
}

class _PDFThumbnailWidgetState extends State<PDFThumbnailWidget> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    final file = await DefaultCacheManager().getSingleFile(widget.pdfUrl);
    setState(() {
      localPath = file.path;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              //  border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              child: PDFView(
                filePath: localPath,
                defaultPage: 0,
                // Show the first page
                enableSwipe: false,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: false,
                // fitPolicy: FitPolicy.BOTH,
                onRender: (_pages) {
                  // PDF is rendered
                },
                onError: (error) {
                  print(error.toString());
                },
                onPageError: (page, error) {
                  print('$page: ${error.toString()}');
                },
                onPageChanged: (int? page, int? total) {
                  print('page change: $page/$total');
                },
              ),
            ),
          );
  }
}
