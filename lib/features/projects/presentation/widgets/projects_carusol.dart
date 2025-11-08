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
      return const SizedBox.shrink(); // ✅ أفضل من Text
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
              final imagePath =
                  images[imgIndex].toString().startsWith('assets/')
                      ? images[imgIndex].toString().replaceFirst('assets/', '')
                      : images[imgIndex].toString();

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

  /// ✅ الحل الأساسي: استخدام Image.network للويب
  Widget _buildImage(String imagePath) {
    if (kIsWeb) {
      // للويب: استخدم المسار المطلق
      return Image.network(
        'assets/$imagePath', // ⚠️ هنا المسار لازم يبدأ بـ assets/
        fit: BoxFit.cover,
        width: 200,
        height: 200,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 50),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
            ),
          );
        },
      );
    } else {
      // للموبايل: Image.asset عادي
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: 200,
        height: 200,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 50),
          );
        },
      );
    }
  }
}
