import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerScreen extends StatelessWidget {
  final YoutubePlayerController controller;
  const VideoPlayerScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            PlayPauseButton(),
            RemainingDuration(),
            // FullScreenButton(),
            PlaybackSpeedButton(),
          ],
        ),
      ),
    );
  }
}
