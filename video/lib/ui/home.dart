import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoPlayerController controller;
  double opacity = 0;
  final TextStyle textStyle =
      const TextStyle(color: Colors.white, fontSize: 18);

  String secondsFotmat(int sec) {
    return sec < 10 ? '0$sec' : sec.toString();
  }

  // https://drive.google.com/uc?export=download&id=1e-Kg-qhgmDw9onOs_t2yRQyDXl22ozV_
  // https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
        'https://drive.google.com/uc?export=download&id=1e-Kg-qhgmDw9onOs_t2yRQyDXl22ozV_');
    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((value) => setState(() {
          print('КОНТРОЛЛЕР ГОТОВ');
          controller.play();
        }));
    print('init готов');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        body: SizedBox(
      height: 300,
      child: controller.value.isInitialized
          ? GestureDetector(
              onTap: () {
                opacity = opacity == 0.0 ? 1.0 : 0.0;
                setState(() {});
              },
              child: Stack(children: [
                VideoPlayer(controller),
                AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 400),
                  child: ColoredBox(
                    color: Colors.black12.withOpacity(0.3),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            MediaButton(
                              icon: Icons.replay_10,
                              onPressed: opacity == 1
                                  ? () {
                                      controller.seekTo(controller
                                              .value.position -
                                          const Duration(milliseconds: 2000));
                                      // setState(() {});
                                    }
                                  : () {
                                      opacity = opacity == 0.0 ? 1.0 : 0.0;
                                      setState(() {});
                                    },
                            ),
                            MediaButton(
                                onPressed: opacity == 1
                                    ? () {
                                        controller.value.isPlaying
                                            ? controller.pause()
                                            : controller.play();
                                        setState(() {});
                                      }
                                    : () {
                                        opacity = opacity == 0.0 ? 1.0 : 0.0;
                                        setState(() {});
                                      },
                                icon: controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow),
                            MediaButton(
                                onPressed: opacity == 1
                                    ? () {
                                        controller.seekTo(controller
                                                .value.position +
                                            const Duration(milliseconds: 2000));
                                        // setState(() {});
                                      }
                                    : () {
                                        opacity = opacity == 0.0 ? 1.0 : 0.0;
                                        setState(() {});
                                      },
                                icon: Icons.forward_10),
                          ]),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Slider(
                                min: 0,
                                max: controller.value.duration.inMilliseconds
                                    .toDouble(),
                                value: controller.value.position.inMilliseconds
                                    .toDouble(),
                                activeColor: Colors.white,
                                inactiveColor: Colors.black12,
                                onChanged: (value) {
                                  controller.seekTo(
                                      Duration(milliseconds: value.toInt()));
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${controller.value.position.inMinutes} : ${secondsFotmat(controller.value.position.inSeconds % 60)}',
                                        style: textStyle),
                                    Text(
                                        '${controller.value.duration.inMinutes} : ${secondsFotmat(controller.value.duration.inSeconds % 60)}',
                                        style: textStyle)
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            )
          : Container(color: Colors.purple),
    ));
  }
}

class MediaButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  const MediaButton({required this.icon, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black26.withOpacity(0.3),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
