import 'package:edulearn/student_dashboard/controller/course_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../core/constants/app_text_styles.dart';


class VideoTab extends StatefulWidget {
  const VideoTab({super.key});

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  YoutubePlayerController? _ytController;

  @override
  void initState() {
    super.initState();

    final courseController = Get.find<CourseDetailController>();
    final videoUrl = courseController.course['videoUrl'];

    if (videoUrl != null) {
      final videoId = YoutubePlayer.convertUrlToId(videoUrl);

      if (videoId != null) {
        _ytController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            controlsVisibleAtStart: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_ytController == null) {
      return Center(
        child: Text(
          "No video available",
          style: AppTextStyles.bodySecondary,
        ),
      );
    }

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _ytController!,
        showVideoProgressIndicator: true,
        onReady: () {},
      ),
      onEnterFullScreen: () {
        // 🔒 Lock landscape
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      },
      onExitFullScreen: () {
        // 🔓 Restore portrait
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      },
      builder: (context, player) {
        final isFullScreen =
            _ytController!.value.isFullScreen;

        // 🎯 FULLSCREEN → VIDEO ONLY
        if (isFullScreen) {
          return player;
        }

        // 📱 PORTRAIT → VIDEO WITH UI
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: player,
            ),
            const SizedBox(height: 12),
            Text(
              "Rotate or tap fullscreen for better viewing",
              style: AppTextStyles.caption,
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _ytController?.dispose();

    // Safety: restore portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }
}
