//
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//
// class PdfViewer extends StatefulWidget {
//   final Uint8List pdfBytes;
//
//  // PdfWidget({required this.pdfBytes});
//   const PdfViewer({super.key,required this.pdfBytes});
//
//   @override
//   State<PdfViewer> createState() => _PdfViewerState();
// }
//
// class _PdfViewerState extends State<PdfViewer> {
//   final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: const Text('Syncfusion Flutter PDF Viewer'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.bookmark,
//               color: Colors.white,
//               semanticLabel: 'Bookmark',
//             ),
//             onPressed: () {
//               _pdfViewerKey.currentState?.openBookmarkView();
//             },
//           ),
//         ],
//       ),
//       body: SfPdfViewer.memory(
//         widget.pdfBytes ,
//       //  'assets/flutter-succinctly.pdf',
//     //    key: _pdfViewerKey,
//       ),
//     );
//   }
// }
