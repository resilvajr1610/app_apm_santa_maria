import 'package:app_apm_santa_maria/componentes/texto_padrao.dart';
import 'package:app_apm_santa_maria/uteis/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TelaEstatutoPDF extends StatelessWidget {
  final String assetPath = 'assets/pdf/estatuto.pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Cores.azul,
         iconTheme: IconThemeData(color: Colors.white),
         title: TextoPadrao(texto: 'Estatuto APM',)),
      body: FutureBuilder<String>(
        future: _loadPdf(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return PDFView(
                filePath: snapshot.data!,
                autoSpacing: true,
                enableSwipe: true,
                pageSnap: true,
                onError: (error) => print(error),
              );
            } else {
              return Center(child: Text('Erro ao carregar o PDF'));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<String> _loadPdf() async {
    final ByteData data = await rootBundle.load(assetPath);
    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile = File('${tempDir.path}/estatuto.pdf');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return tempFile.path;
  }
}
