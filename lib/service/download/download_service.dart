import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class DownloadService {
  Future<String> createAndSavePdf(List<Map<String, String>> answers) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: answers.map((answer) {
              return pw.Padding(
                padding: pw.EdgeInsets.only(bottom: 10),
                child: pw.Text(
                  "Soru: ${answer['question']}\nCevap: ${answer['answer']}",
                  style: pw.TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ),
      );

      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/test_sonuclari.pdf";
      final file = File(filePath);

      await file.writeAsBytes(await pdf.save());

      return filePath;
    } catch (e) {
      print("Error creating PDF: $e");
      rethrow;
    }
  }

  // Future<void> sharePdf(String filePath) async {
  //   await Share.shareFiles([filePath], text: "Test sonuçlarım!");
  // }
  //
  // Future<void> shareViaEmail(String filePath) async {
  //   await Share.shareFiles([filePath], subject: "Test Sonuçları");
  // }
  //
  // Future<void> shareViaWhatsApp(String filePath) async {
  //   await Share.shareFiles([filePath],
  //       text: "WhatsApp'tan paylaşmak için tıklayın!");
  // }
}
