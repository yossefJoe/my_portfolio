
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:universal_io/io.dart' show Platform;
import 'dart:html' as html;

class DownloadCVButton extends StatelessWidget {
  const DownloadCVButton({super.key});

  final String filePath = 'assets/Youssef-Mahmoud-CV.pdf';

  Future<void> _downloadCV() async {
    try {
      final byteData = await rootBundle.load(filePath);
      final bytes = byteData.buffer.asUint8List();

      if (Platform.operatingSystem == 'web') {
        final blob = html.Blob([bytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);

        final anchor =
            html.AnchorElement(href: url)
              ..setAttribute('download', 'Youssef-Mahmoud-CV.pdf')
              ..style.display = 'none';

        html.document.body!.append(anchor);
        anchor.click();
        anchor.remove();

        html.Url.revokeObjectUrl(url);
      } else {
        // أي منصة تانية (مش المفروض توصل هنا)
        print('⚠️ Not running on web');
      }
    } catch (e) {
      print('❌ Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white.withOpacity(0.6)),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: _downloadCV,
      child: const Text("Download CV"),
    );
  }
}
