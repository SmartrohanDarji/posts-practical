import 'package:post_flutter_practical/features/feat_posts/bloc/post_bloc.dart';

abstract class PostRepository {
  Future<GetPostsState> getPosts();
}
