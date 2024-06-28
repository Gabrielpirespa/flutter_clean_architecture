import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ApodVideo extends StatefulWidget {
  final String url;
  const ApodVideo({super.key, required this.url});

  @override
  State<ApodVideo> createState() => _ApodVideoState();
}

class _ApodVideoState extends State<ApodVideo> {
  late String url;
  VideoPlatform videoPlatform = VideoPlatform.standard;

  VideoPlayerController? videoPlayerController;
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    url = widget.url;
    checkVideoPlatform();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  disposeControllers() {
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
    if (youtubePlayerController != null) {
      youtubePlayerController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildVideoPlayer();
  }

  void checkVideoPlatform() {
    String youtubeHost = "https://www.youtube.com";
    String vimeoHost = "https://www.vimeo.com";

    if (url.substring(0, youtubeHost.length) == youtubeHost) {
      videoPlatform = VideoPlatform.youtube;
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? "",
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
      setState(() {});
    } else if (url.substring(0, vimeoHost.length) == vimeoHost) {
      videoPlatform = VideoPlatform.vimeo;
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Widget buildVideoPlayer() {
    Widget videoWidget;

    if (videoPlatform == VideoPlatform.youtube) {
      videoWidget = YoutubePlayer(controller: youtubePlayerController!);
    } else if (videoPlatform == VideoPlatform.vimeo) {
      videoWidget = VimeoVideoPlayer(
        url: url,
        autoPlay: false,
      );
    } else {
      if (videoPlayerController!.value.hasError) {
        videoWidget = const Text(
            "Sorry! It wasn't possible to play the video. Try it on your browser");
      }

      videoWidget = GestureDetector(
        onTap: () {
          videoPlayerController!.value.isPlaying
              ? videoPlayerController!.pause()
              : videoPlayerController!.play();
        },
        child: Container(
          color:
              Colors.black, // colocar isso para não ficar transparente o vídeo
          child: videoPlayerController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController!),
                )
              : Container(),
        ),
      );

      videoPlayerController!.play();
    }

    return videoWidget;
  }
}

enum VideoPlatform { standard, youtube, vimeo }
