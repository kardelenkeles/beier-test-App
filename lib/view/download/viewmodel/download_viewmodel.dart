import 'package:beier_app2/service/download/download_service.dart';
import 'package:flutter/material.dart';

class DownloadViewModel extends ChangeNotifier {
  final DownloadService _downloadService = DownloadService();
  String? _pdfPath;
  bool _isLoading = false;
  String? _errorMessage;

  String? get pdfPath => _pdfPath;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> generatePdf(List<Map<String, String>> answers) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pdfPath = await _downloadService.createAndSavePdf(answers);
    } catch (e) {
      _errorMessage = "Failed to create PDF: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> sharePdf() async {
  //   if (_pdfPath != null) {
  //     await _downloadService.sharePdf(_pdfPath!);
  //   }
  // }
  //
  // Future<void> shareViaEmail() async {
  //   if (_pdfPath != null) {
  //     await _downloadService.shareViaEmail(_pdfPath!);
  //   }
  // }
  //
  // Future<void> shareViaWhatsApp() async {
  //   if (_pdfPath != null) {
  //     await _downloadService.shareViaWhatsApp(_pdfPath!);
  //   }
  // }
}
