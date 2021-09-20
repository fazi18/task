import 'package:figme_task_app/logic/album_bloc/bloc/album_bloc.dart';
import 'package:figme_task_app/logic/post_bloc/bloc/post_bloc.dart';
import 'package:figme_task_app/resources/repositories/album_repository.dart';
import 'package:figme_task_app/ui/screens/add_screen.dart';
import 'package:figme_task_app/ui/screens/detail_screen.dart';
import 'package:figme_task_app/ui/screens/home_screen.dart';
import 'package:figme_task_app/ui/screens/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic/user_bloc/bloc/user_bloc.dart';
import 'resources/repositories/post_repository.dart';
import 'resources/repositories/user_repository.dart';

class App extends StatelessWidget {
  final UserRepository userRepository;
  final PostRepository postRepository;
  final AlbumRepository albumRepository;
  const App({
    Key? key,
    required this.userRepository,
    required this.postRepository,
    required this.albumRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(userRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => SetPostBloc(postRepository: postRepository),
        ),
        BlocProvider(
          create: (context) => PostBloc(postRepository: postRepository),
        ),
        BlocProvider(
          create: (context) => AlbumBloc(albumRepository: albumRepository),
        ),
      ],
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          theme: ThemeData.light(),
          routes: {
            '/': (context) => HomeScreen(),
            '/detail': (context) => DetailScreen(),
            '/add_edit': (context) => AddScreen(),
            '/video_player': (context) => VideoPlayerScreen(),
          },
        ),
        designSize: const Size(414, 896),
      ),
    );
  }
}
