import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/widgets/app_colors.dart';
import '../cubits/dot_indicator_cubit.dart';

class PostActionWidget extends StatelessWidget {
  final List<String> images;

  const PostActionWidget({required this.images, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 16,
            child: Row(
              children: [
                Image.asset(
                  'assets/like_icon.png',
                  height: 24,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/comment_icon.png',
                  height: 26,
                ),
              ],
            ),
          ),
          if (images.isNotEmpty && images.length > 1) ...[
            BlocBuilder<DotIndicatorCubit, int>(builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(state),
              );
            })
          ],
          Positioned(
            right: 16,
            child: Image.asset(
              'assets/bookmark_icon.png',
              height: 22,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator(int position) {
    final List<Widget> pageIndicatorViews = [];
    for (int i = 0; i < images.length; i++) {
      pageIndicatorViews.add(i == position ? _indicator(true) : _indicator(false));
    }
    return pageIndicatorViews;
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 18 : 14.0,
        width: isActive ? 18 : 14.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.72),
                    blurRadius: 2.0,
                    spreadRadius: 0.5,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color:
              isActive ? AppColors.primaryColor : AppColors.unFocusedColor /*const Color(0XFFEAEAEA)*/,
        ),
      ),
    );
  }
}
