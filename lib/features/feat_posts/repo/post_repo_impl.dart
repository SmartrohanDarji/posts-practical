import 'package:dio/dio.dart';
import 'package:post_flutter_practical/core/api_provider.dart';
import 'package:post_flutter_practical/core/constanant%20/api_end_points.dart';
import 'package:post_flutter_practical/core/constanant%20/constants.dart';
import 'package:post_flutter_practical/features/feat_posts/bloc/post_bloc.dart';
import 'package:post_flutter_practical/features/feat_posts/models/post_model.dart';
import 'package:post_flutter_practical/features/feat_posts/repo/post_repo.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiProvider apiClient;

  PostRepositoryImpl({required this.apiClient});

  @override
  Future<GetPostsState> getPosts() async {
    try {
      final response = await apiClient.get(
        kGetPostsEndPoint,
        params: {"key": kKeyValue},
      );

      if (response.statusCode == 200) {
        final List<PostModel> posts = (response.data as List)
            .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return GetPostsState(posts: posts);
      } else {
        return GetPostsState(
          errorMessage: response.data['message'] ??
              'Failed to getPosts: ${response.statusMessage ?? 'Unknown error'}',
        );
      }
    } on DioException catch (e) {
      return GetPostsState(
        errorMessage: 'Failed to getPosts: ${e.message ?? 'Unknown error'}',
      );
    } catch (e) {
      return GetPostsState(
        errorMessage: 'An unexpected error occurred: $e',
      );
    }
  }
}
