import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatelessWidget {
  final String? thumbnailUrl;
  final String? videoUrl;

  const VideoCard({
    super.key,
    this.thumbnailUrl,
    this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (videoUrl != null) {
          // Navigate to a video player page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerPage(videoUrl: videoUrl!),
            ),
          );
        }
      },
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: thumbnailUrl ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.asset(
                'assets/video_default_thumbnail.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Image.asset(
              'assets/play_icon.png',
              height: 54,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class VideoPlayerPage extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerPage({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video")),
      body: Center(
        child: VideoPlayerWidget(videoUrl: videoUrl),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ValueNotifier<bool> isPlaying;
  late ValueNotifier<double> videoPosition;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });

    isPlaying = ValueNotifier<bool>(false);
    videoPosition = ValueNotifier<double>(0);

    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        videoPosition.value = _controller.value.position.inSeconds.toDouble();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              // Play/Pause button at the center
              ValueListenableBuilder<bool>(
                valueListenable: isPlaying,
                builder: (context, playing, child) {
                  return IconButton(
                    icon: Icon(
                      playing ? Icons.pause : Icons.play_arrow,
                      size: 60,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (playing) {
                          _controller.pause();
                          isPlaying.value = false;
                        } else {
                          _controller.play();
                          isPlaying.value = true;
                        }
                      });
                    },
                  );
                },
              ),
              // Video control bar at the bottom
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Slider for video position
                    ValueListenableBuilder<double>(
                      valueListenable: videoPosition,
                      builder: (context, position, child) {
                        double videoDuration =
                            _controller.value.duration.inSeconds.toDouble();
                        return Slider(
                          value: position,
                          min: 0,
                          max: videoDuration,
                          onChanged: (newPosition) {
                            setState(() {
                              _controller.seekTo(
                                  Duration(seconds: newPosition.toInt()));
                              videoPosition.value = newPosition;
                            });
                          },
                        );
                      },
                    ),
                    // Current position and duration text
                    ValueListenableBuilder<double>(
                      valueListenable: videoPosition,
                      builder: (context, position, child) {
                        final duration = _controller.value.duration;
                        final positionText =
                            formatDuration(Duration(seconds: position.toInt()));
                        final durationText = formatDuration(duration);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(positionText,
                                style: const TextStyle(color: Colors.white)),
                            Text(durationText,
                                style: const TextStyle(color: Colors.white)),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    isPlaying.dispose();
    videoPosition.dispose();
  }
}
