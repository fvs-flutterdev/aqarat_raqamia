// import 'dart:io';
//
// import 'package:flutter/services.dart';
// //import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// //import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// //import 'package:pdf/widgets.dart';
// import 'package:pdf/widgets.dart' as pw;
// // import 'package:pdf/widgets.dart' as pw;
// // import 'package:pdf/widgets.dart' as pw;
//
// Future<void> generatePDF(Map<String, dynamic> data) async {
//   final pdf = pw.Document();
//
//   // Create a PDF widget for each key-value pair in the data map
//   final List<pw.Widget> pdfWidgets = data.entries
//       .map((entry) => pw.Container(
//     margin: const pw.EdgeInsets.symmetric(vertical: 10),
//     child: pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       children: [
//         pw.Text(entry.key),
//         pw.Text(entry.value.toString()),
//       ],
//     ),
//   ))
//       .toList();
//
//   // Add the PDF widgets to the document
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Column(children: pdfWidgets),
//     ),
//   );
//
//   // Save the PDF to a file
//   final output = await getTemporaryDirectory();
//   final filePath = '${output.path}/profile.pdf';
//   final file = File(filePath);
//   await file.writeAsBytes(await pdf.save());
//
//   // Open the PDF file
//  // OpenFile.open(filePath);
// }
//
//
// // Future<void> generatePDFs(Map<String, dynamic> data) async {
// //   final pdf = pw.Document();
// //
// //   // Load the Arabic font
// //   final fontData = await rootBundle.load('font/Changa-Regular.ttf');
// //   final arabicFont = pw.Font.ttf(fontData);
// //
// //   // Create a PDF widget for each key-value pair in the data map
// //   final List<pw.Widget> pdfWidgets = data.entries
// //       .map((entry) => pw.Container(
// //     margin: const pw.EdgeInsets.symmetric(vertical: 10),
// //     child: pw.Row(
// //       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
// //       children: [
// //         pw.Text(entry.key, style: pw.TextStyle(font: arabicFont)),
// //         pw.Text(entry.value.toString()),
// //       ],
// //     ),
// //   ))
// //       .toList();
// //
// //   // Add the PDF widgets to the document
// //   pdf.addPage(
// //     pw.Page(
// //       build: (pw.Context context) => pw.Column(children: pdfWidgets),
// //     ),
// //   );
// //
// //   // Save the PDF to a file
// //   final output = await getTemporaryDirectory();
// //   final filePath = '${output.path}/data.pdf';
// //   final file = File(filePath);
// //   await file.writeAsBytes(await pdf.save());
// //
// //   // Open the PDF file
// //   OpenFile.open(filePath);
// // }