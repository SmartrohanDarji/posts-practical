part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();
}

class GetPostsEvent extends PostEvent {
  const GetPostsEvent();
  @override
  List<Object> get props => [];
}
