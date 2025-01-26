import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:post_flutter_practical/core/utils/widgets/cache_network_image.dart';
import 'package:post_flutter_practical/features/feat_posts/cubits/dot_indicator_cubit.dart';

import 'video_card.dart';

class MediaCard extends StatelessWidget {
  final List<String> images;
  final String thumbnail;
  final bool hasVideo;

  const MediaCard({
    super.key,
    required this.images,
    required this.hasVideo,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PhotoViewerPage(images: images, initialIndex: index),
              ),
            );
          },
          child: _adjustToVideo(index),
        );
      },
      physics: const BouncingScrollPhysics(),
      onPageChanged: (index) {
        context.read<DotIndicatorCubit>().changeIndicator(index);
      },
      itemCount: images.length,
    );
  }

  Widget _adjustToVideo(int index) {
    if (hasVideo && index == 0) {
      return VideoCard(
        thumbnailUrl: thumbnail,
        videoUrl: images.first,
      );
    } else {
      return CachedImageWidget(
        imageUrl: images[index],
        height: 300,
        width: double.infinity,
        boxFit: BoxFit.cover,
      );
    }
  }
}

class PhotoViewerPage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const PhotoViewerPage(
      {super.key, required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image")),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}
