import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'fullscreen_view.dart';

class ProjectsCarusol extends StatelessWidget {
  const ProjectsCarusol({Key? key, required this.images}) : super(key: key);
  final List<dynamic> images;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 0.2,
      ),
      itemBuilder: (context, imgIndex, realIdx) {
        final imagePath = images[imgIndex];
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
              child: Image.asset(
                images[imgIndex].startsWith('assets/')
                    ? images[imgIndex].replaceFirst('assets/', '')
                    : images[imgIndex],
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
          ),
        );
      },
    );
  }
}
