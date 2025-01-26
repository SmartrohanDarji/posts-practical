import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:post_flutter_practical/core/common/cache_manager.dart';
import 'package:post_flutter_practical/core/utils/widgets/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      cacheManager: ImageCacheManager(),
      fit: boxFit ?? BoxFit.fill,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: AppColors.lightWhiteColor,
        highlightColor: Colors.blue.shade50,
        child: Container(
          width: width ?? 200,
          height: height ?? 200,
          color: AppColors.lightWhiteColor,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width ?? 200,
        height: height ?? 200,
        color: AppColors.lightWhiteColor.withValues(alpha: 0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image,
              color: Colors.grey.shade400,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              'Image Not Available',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
