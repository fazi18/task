part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class AllPostsEvent extends PostEvent {
  final String userID;
  AllPostsEvent({required this.userID});
}

class PostInitialEvent extends PostEvent {}

class SetPostEvent extends PostEvent {
  final String id;
  final String title;
  final String body;

  SetPostEvent({required this.id, required this.title, required this.body});
}

class SetPostShowValueEvent extends PostEvent {
  final int index;
  SetPostShowValueEvent({required this.index});
}

class SetPostEditEvent extends PostEvent {
  final int index;
  final String id;
  final String title;
  final String body;
  SetPostEditEvent({
    required this.index,
    required this.id,
    required this.title,
    required this.body,
  });
}

class SetPostIdExistEvent extends PostEvent {
  final List<Post> posts;
  SetPostIdExistEvent({required this.posts});
}

class DeletePostEvent extends PostEvent {
  final String id;

  DeletePostEvent({required this.id});
}

class BackToSetStateEvent extends PostEvent {}
