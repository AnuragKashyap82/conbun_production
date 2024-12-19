import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../utils/colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final bool isAppBar;
  const VideoPlayerScreen({super.key, required this.videoUrl, required this.isAppBar});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl, // replace with your video URL
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isAppBar?colorBackground:Colors.transparent,
      appBar: widget.isAppBar?AppBar(
        backgroundColor: colorWhite,
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.1),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: colorViolet,
              size: 20,
            )),
        title: const Text(
          "Portfolio",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
      ):null,
      body:
      Center(
        child: _controller.value.isInitialized
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    SizedBox(height: 26),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 42,
                          width: MediaQuery.of(context).size.width *0.9,
                          decoration: BoxDecoration(
                              color: colorBlack.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: VideoProgressIndicator(
                              _controller,
                              padding: EdgeInsets.zero,
                              allowScrubbing: true,
                              colors: VideoProgressColors(
                                playedColor: colorOrange,
                                backgroundColor: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Container(
                          height: 42,
                          width: MediaQuery.of(context).size.width *0.6,
                          decoration: BoxDecoration(
                            color: colorBlack,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child:  Center(
                            child: Text(
                              _controller.value.isPlaying? "Pause":"Play",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Bold",
                                color:colorWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            )
            : CircularProgressIndicator(),
      ),
    );
  }
}
