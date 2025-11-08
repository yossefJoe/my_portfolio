import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class DownloadCVButton extends StatelessWidget {
  const DownloadCVButton({super.key});

  final String filePath = 'assets/Youssef-Mahmoud-CV.pdf';

  Future<void> _downloadCV(BuildContext context) async {
    try {
      if (kIsWeb) {
        // ✅ للويب: تحميل الملف من assets
        final byteData = await rootBundle.load(filePath);
        final bytes = byteData.buffer.asUint8List();

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

        // ✅ رسالة نجاح
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ CV downloaded successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        debugPrint('⚠️ Not running on web');
      }
    } catch (e) {
      debugPrint('❌ Error downloading CV: $e');

      // ✅ رسالة خطأ
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Failed to download CV: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
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
      onPressed: () => _downloadCV(context),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.download, size: 18),
          SizedBox(width: 8),
          Text("Download CV"),
        ],
      ),
    );
  }
}
