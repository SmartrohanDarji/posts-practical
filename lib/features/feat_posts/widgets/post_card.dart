import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:post_flutter_practical/core/utils/widgets/app_colors.dart';
import 'package:post_flutter_practical/features/feat_posts/models/post_model.dart';
import 'package:post_flutter_practical/features/feat_posts/widgets/description_card.dart';
import 'package:post_flutter_practical/features/feat_posts/widgets/media_card.dart';
import 'package:post_flutter_practical/features/feat_posts/widgets/post_action_widget.dart';

class Postcard extends StatelessWidget {
  final PostModel post;

  const Postcard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: AppColors.lightBackground2.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.mediaUrls.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: MediaCard(
                key: ValueKey(post.id),
                images: post.mediaUrls,
                hasVideo: post.videoUrl.isNotEmpty,
                thumbnail: post.thumbnailUrl ?? '',
              ),
            ),
            const Gap(12),
            PostActionWidget(images: post.mediaUrls),
          ],
          if (post.description != null) ...[
            const Divider(thickness: 1, color: AppColors.lightGreyColor),
            const Gap(10),
            DescriptionCard(description: post.description),
          ]
        ],
      ),
    );
  }
}
