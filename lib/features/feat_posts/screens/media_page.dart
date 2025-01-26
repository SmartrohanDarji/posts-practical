import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_flutter_practical/core/utils/widgets/app_colors.dart';
import 'package:post_flutter_practical/features/feat_posts/bloc/post_bloc.dart';
import 'package:post_flutter_practical/features/feat_posts/cubits/dot_indicator_cubit.dart';
import 'package:post_flutter_practical/features/feat_posts/widgets/post_card.dart';

import '../../../injection.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground1,
      appBar: AppBar(
        title: const Text('Media Page'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        buildWhen: (previous, current) =>
            current is GetPostsLoadingState || current is GetPostsState,
        builder: (context, state) {
          if (state is GetPostsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetPostsState) {
            if (state.errorMessage == null) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 30,
                    thickness: 30,
                    color: AppColors.lightBackground1,
                  );
                },
                itemCount: state.posts != null ? state.posts!.length : 0,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final post = state.posts?[index];
                  return BlocProvider<DotIndicatorCubit>(
                    create: (context) => sl<DotIndicatorCubit>(),
                    child: Postcard(
                      post: post!,
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text(state.errorMessage ?? ""));
            }
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}
