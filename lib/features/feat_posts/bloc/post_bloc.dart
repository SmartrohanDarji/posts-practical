import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_flutter_practical/features/feat_posts/models/post_model.dart';
import 'package:post_flutter_practical/features/feat_posts/repo/post_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(const PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetPostsEvent) {
        emit(const GetPostsLoadingState());
        GetPostsState getPostsState = await postRepository.getPosts();
        emit(getPostsState);
      }
    });
  }
}
