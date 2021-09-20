import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:figme_task_app/models/post.dart';
import 'package:figme_task_app/resources/repositories/post_repository.dart';
import 'package:http/http.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  late PostList postList;
  late List<Post> userPost;
  PostBloc({required this.postRepository}) : super(PostInitialState());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is AllPostsEvent) {
      yield PostLoadingState();
      try {
        postList = await postRepository.fetchAllPosts(event.userID);
        yield PostLoadedState(posts: postList);
      } on SocketException {
        yield PostErrorstate(
          error: ('No Internet'),
        );
      } on HttpException {
        yield PostErrorstate(
          error: ('No Service'),
        );
      } on FormatException {
        yield PostErrorstate(
          error: ('No Formate Exception'),
        );
      } catch (e) {
        print(e.toString());
      }
    }
  }
}

class SetPostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  late List<Post> myPosts;
  SetPostBloc({required this.postRepository}) : super(PostInitialState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is SetPostEvent) {
      yield PostLoadingState();
      try {
        myPosts =
            await postRepository.setPost(event.id, event.title, event.body);
        yield PostSetState(myPosts: myPosts);
      } on SocketException {
        yield PostErrorstate(
          error: ('No Internet'),
        );
      } on HttpException {
        yield PostErrorstate(
          error: ('No Service'),
        );
      } on FormatException {
        yield PostErrorstate(
          error: ('No Formate Exception'),
        );
      } catch (e) {
        print(e.toString());
      }
    } else if (event is PostInitialEvent) {
      yield PostInitialState();
    } else if (event is SetPostIdExistEvent) {
      yield PostIdWasExistState(myPosts: event.posts);
    } else if (event is SetPostShowValueEvent) {
      yield PostValueShowState(index: event.index, myPosts: myPosts);
    } else if (event is SetPostEditEvent) {
      myPosts = postRepository.putPost(
          event.id, event.title, event.body, event.index);
      yield PostLoadingState();
      try {
        yield PostSetState(myPosts: myPosts);
      } catch (e) {
        print(e);
      }
    } else if (event is DeletePostEvent) {
      myPosts = postRepository.deletePost(event.id);
      yield PostLoadingState();
      try {
        yield PostSetState(myPosts: myPosts);
      } catch (e) {
        print(e);
      }
    } else if (event is BackToSetStateEvent) {
      yield PostSetState(myPosts: myPosts);
    }
  }

  // _setPostSetState() async* {
  //   yield PostLoadingState();
  //   try {
  //     Future.delayed(Duration(milliseconds: 1000));
  //     yield PostSetState(myPosts: myPosts);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
