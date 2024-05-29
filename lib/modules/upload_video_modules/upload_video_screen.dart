import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_cubit/upload_video_cubit.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_cubit/upload_video_states.dart';

import '../../permission_cubit/permission_cubit.dart';
import '../../permission_cubit/permission_states.dart';

class UploadVideoScreen extends StatelessWidget {
  const UploadVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Video'),
      ),
      body: BlocProvider(
        create: (context) => UploadVideoCubit(),
        child: BlocConsumer<UploadVideoCubit, UploadVideoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            UploadVideoCubit uploadVideoCubit = UploadVideoCubit.get(context);
            return Column(
              children: [
                Text('add new VID'),
                BlocConsumer<PermissionsCubit, PermissionsStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      PermissionsCubit permissionCubit =
                          PermissionsCubit.get(context);
                      return ElevatedButton(
                          onPressed: () {
                            permissionCubit.requestPermission(
                                context: context,
                                permissionType: PermissionType.video,
                                functionWhenGranted:
                                    uploadVideoCubit.pickVideo);
                          },
                          child: Text('pick video'));
                    }),
                // ElevatedButton(
                //     onPressed: () {
                //       uploadVideoCubit.pickVideo();
                //     },
                //     child: Text('pick video')),
              ],
            );
          },
        ),
      ),
    );
  }
}
