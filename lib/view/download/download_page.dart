import 'package:auto_route/annotations.dart';
import 'package:beier_app2/view/answer/answer_viewmodel.dart';
import 'package:beier_app2/view/download/viewmodel/download_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class DownloadPage extends StatefulWidget {
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final answers =
          Provider.of<AnswerViewModel>(context, listen: false).answers;
      Provider.of<DownloadViewModel>(context, listen: false)
          .generatePdf(answers);
    });
  }

  @override
  Widget build(BuildContext context) {
    final downloadViewModel = Provider.of<DownloadViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Sonuçları İndir")),
      body: Center(
        child: downloadViewModel.isLoading
            ? CircularProgressIndicator()
            : downloadViewModel.errorMessage != null
                ? Text(
                    downloadViewModel.errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "PDF başarıyla oluşturuldu!",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          // downloadViewModel.sharePdf();
                        },
                        icon: Icon(Icons.share),
                        label: Text("Paylaş"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // downloadViewModel.shareViaEmail();
                        },
                        icon: Icon(Icons.email),
                        label: Text("E-posta ile Gönder"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // downloadViewModel.shareViaWhatsApp();
                        },
                        icon: Icon(Icons.message),
                        label: Text("WhatsApp ile Gönder"),
                      ),
                    ],
                  ),
      ),
    );
  }
}
