import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets/video_player_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoController;
  @override
  void initState() {
    super.initState();

    videoController = VideoPlayerController.network(
        'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => videoController.play());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VideoPlayerWidget(controller: videoController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }
}
