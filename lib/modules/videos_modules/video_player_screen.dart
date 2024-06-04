import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/videos_modules/video_card.dart';
import 'package:videos_application/modules/videos_modules/videos_cubit/videos_cubit.dart';
import 'package:videos_application/modules/videos_modules/videos_cubit/videos_states.dart';

import '../upload_video_modules/upload_video_screen.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosCubit()..getVideosData(),
      child: BlocConsumer<VideosCubit, VideosStates>(
        listener: (context, state) {},
        builder: (context, state) {
          VideosCubit videosCubit = VideosCubit.get(context);
          // print(videosCubit.getVideosModel!.videos!.length);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Videos'),
              actions: [
                // IconButton(
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const UploadVideoScreen(),
                //           ));
                //     },
                //     icon: const Icon(Icons.video_collection_outlined)),
              ],
            ),
            body: videosCubit.getVideosModel == null
                ? const Text('Loading')
                : PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: PageController(
                      initialPage: 0,
                      viewportFraction: 1,
                    ),
                    // onPageChanged: (index) {
                    //   index = index %
                    //       (feedViewModel.videoSource!.listVideos.length);
                    //   feedViewModel.changeVideo(index);
                    // },
                    itemBuilder: (context, index) => VideoCard(
                      videosCubit: videosCubit,
                      postModel: videosCubit.getVideosModel!.videos![index],
                    ),
                    itemCount: videosCubit.getVideosModel!.videos!.length,
                  ),
          );
        },
      ),
    );
  }
}
