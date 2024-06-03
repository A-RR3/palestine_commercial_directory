import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_cubit/upload_video_cubit.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_cubit/upload_video_states.dart';
import 'package:videos_application/shared/widgets/my_text_form_field.dart';

import '../../permission_cubit/permission_cubit.dart';
import '../../permission_cubit/permission_states.dart';

class UploadVideoScreen extends StatelessWidget {
  const UploadVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Video'),
      ),
      body: BlocProvider(
        create: (context) => UploadVideoCubit(),
        child: BlocConsumer<UploadVideoCubit, UploadVideoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            UploadVideoCubit uploadVideoCubit = UploadVideoCubit.get(context);
            return Form(
              key: uploadVideoCubit.addPostFormKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextFormField(
                      label: 'title',
                      controller: uploadVideoCubit.titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'title is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      label: 'content',
                      controller: uploadVideoCubit.contentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'content is required';
                        }
                        return null;
                      },
                    ),
                    BlocConsumer<PermissionsCubit, PermissionsStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          PermissionsCubit permissionCubit =
                              PermissionsCubit.get(context);
                          return TextButton(
                              onPressed: () async {
                                await permissionCubit.requestPermission(
                                  context: context,
                                  permissionType: PermissionType.video,
                                  functionWhenGranted:
                                      uploadVideoCubit.pickVideo,
                                );
                                print('before compress');
                                if (uploadVideoCubit.video != null) {
                                  uploadVideoCubit.compressVideo(
                                      uploadVideoCubit.video!.path);
                                }
                                print('after conmpress');
                              },
                              child: Text('pick video'));
                        }),
                    ElevatedButton(
                      onPressed: () {
                        if (uploadVideoCubit.addPostFormKey.currentState!
                            .validate()) {
                          uploadVideoCubit.addVideo(
                            title: uploadVideoCubit.titleController.text,
                            content: uploadVideoCubit.contentController.text,
                            videoFile:
                            uploadVideoCubit.mediaInfo != null
                                ? File(uploadVideoCubit.mediaInfo!.path!)
                                : null,
                            // uploadVideoCubit.video != null
                            //     ? File(uploadVideoCubit.video!.path)
                            //     : null,
                          );
                        }
                      },
                      child: Text('add post with video'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
