// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// class PDFThumbnailBase64Widget extends StatefulWidget {
//   final String base64String;
//
//   const PDFThumbnailBase64Widget({Key? key, required this.base64String}) : super(key: key);
//
//   @override
//   _PDFThumbnailBase64WidgetState createState() => _PDFThumbnailBase64WidgetState();
// }
//
// class _PDFThumbnailBase64WidgetState extends State<PDFThumbnailBase64Widget> {
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
//     // Decode the Base64 string
//     final bytes = base64.decode(widget.base64String);
//
//     // Save the decoded bytes as a temporary PDF file
//     final dir = await getTemporaryDirectory();
//     final file = File('${dir.path}/temp.pdf');
//     await file.writeAsBytes(bytes, flush: true);
//
//     setState(() {
//       localPath = file.path;
//       isLoading = false;
//     });
//     print('???????????????????All Done !');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(child: CircularProgressIndicator())
//         : Container(
//       width: 150, // Adjust the size of the thumbnail
//       height: 200,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: PDFView(
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

import 'dart:convert';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/dimention.dart';

class PDFThumbnailBase64Widget extends StatefulWidget {
  final String base64PDF;

  // final String base64String;

  const PDFThumbnailBase64Widget({Key? key, required this.base64PDF})
      : super(key: key);

  @override
  _PDFThumbnailBase64WidgetState createState() =>
      _PDFThumbnailBase64WidgetState();
}

class _PDFThumbnailBase64WidgetState extends State<PDFThumbnailBase64Widget> {
  String? localPath;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    if (widget.base64PDF.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = 'Base64 string is empty';
      });
      return;
    }

    try {
      // Decode the Base64 string
      final bytes = base64.decode(widget.base64PDF);

      // Save the decoded bytes as a temporary PDF file
      final dir = await getTemporaryDirectory();
      final file =
          File('${dir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(bytes, flush: true);

      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      print('Error decoding or saving PDF: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load PDF';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // Ensure localPath is not null
    if (localPath == null) {
      return Center(child: Text('Invalid file path'));
    }

    // Ensure the file exists
    if (!File(localPath!).existsSync()) {
      return Center(child: Text('PDF file not found'));
    }

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // height: context.height * 0.15.sp,
      // width: context.width * 0.24.sp,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        //  border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.RADIUS_DEFAULT),
        ),
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
        child: PDFView(
          filePath: localPath!,
          defaultPage: 0,
          enableSwipe: false,
          swipeHorizontal: false,
          autoSpacing: false,
          pageFling: false,
          //  fitPolicy: FitPolicy.BOTH,
          onRender: (_pages) {
            print('PDF rendered');
            print('<<<<<<$_pages>>>>>>');
          },
          onError: (error) {
            print('PDFView error: $error');
          },
          onPageError: (page, error) {
            print('Page $page error: $error');
          },
          onPageChanged: (int? page, int? total) {
            print('Page changed: $page/$total');
          },
        ),
      ),
    );
  }
}
