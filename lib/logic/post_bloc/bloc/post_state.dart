part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final PostList posts;
  PostLoadedState({required this.posts});
}

class PostErrorstate extends PostState {
  final error;
  PostErrorstate({this.error});
}

class PostSetState extends PostState {
  final List<Post> myPosts;
  PostSetState({required this.myPosts});
}

class PostValueShowState extends PostState {
  List<Post> myPosts;
  final int index;
  PostValueShowState({required this.index, required this.myPosts});
}

class PostIdWasExistState extends PostState {
  final List<Post> myPosts;
  PostIdWasExistState({required this.myPosts});
}
