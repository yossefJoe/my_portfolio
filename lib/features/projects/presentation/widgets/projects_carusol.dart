import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'fullscreen_view.dart';

class ProjectsCarusol extends StatelessWidget {
  const ProjectsCarusol({Key? key, required this.images}) : super(key: key);
  final List<dynamic> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = 200.0;
        final width =
            constraints.maxWidth == double.infinity
                ? MediaQuery.of(context).size.width
                : constraints.maxWidth;

        return SizedBox(
          height: height,
          width: width,
          child: CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
              height: height,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 0.2,
            ),
            itemBuilder: (context, imgIndex, realIdx) {
              String imagePath = images[imgIndex].toString();

              // ✅ للويب: إزالة "assets/" من البداية
              if (kIsWeb && imagePath.startsWith('assets/')) {
                imagePath = imagePath.substring(7); // إزالة "assets/"
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullScreenImageView(imagePath: imagePath),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildImage(imagePath),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildImage(String imagePath) {
    if (kIsWeb) {
      // ✅ للويب: Image.network من مجلد assets مباشرة
      return Image.network(
        'assets/$imagePath',
        fit: BoxFit.cover,
        width: 200,
        height: 200,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('❌ Failed to load: assets/$imagePath');
          return Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              border: Border.all(color: Colors.red.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, size: 40, color: Colors.red[300]),
                SizedBox(height: 8),
                Text(
                  'Image Error',
                  style: TextStyle(color: Colors.red[300], fontSize: 10),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    imagePath.split('/').last,
                    style: TextStyle(color: Colors.white54, fontSize: 8),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 200,
            height: 200,
            color: Colors.grey[850],
            child: Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                strokeWidth: 2,
                color: Colors.white54,
              ),
            ),
          );
        },
      );
    } else {
      // ✅ للموبايل: Image.asset عادي
      return Image.asset(
        'assets/$imagePath',
        fit: BoxFit.cover,
        width: 200,
        height: 200,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 200,
            height: 200,
            color: Colors.grey[800],
            child: Icon(Icons.broken_image, size: 40, color: Colors.white54),
          );
        },
      );
    }
  }
}
