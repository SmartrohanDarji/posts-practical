part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();
}

final class PostInitial extends PostState {
  const PostInitial();

  @override
  List<Object> get props => [];
}

class GetPostsLoadingState extends PostState {
  const GetPostsLoadingState();

  @override
  List<Object> get props => [];
}

class GetPostsState extends PostState {
  final String? errorMessage;
  final List<PostModel>? posts;

  const GetPostsState({this.errorMessage, this.posts});

  @override
  List<Object?> get props => [errorMessage, posts];
}
