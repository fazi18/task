import 'package:figme_task_app/resources/repositories/album_repository.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'resources/repositories/post_repository.dart';
import 'resources/repositories/user_repository.dart';

void main() {
  runApp(App(
    userRepository: UserRepository(),
    postRepository: PostRepository(),
    albumRepository: AlbumRepository(),
  ));
}
