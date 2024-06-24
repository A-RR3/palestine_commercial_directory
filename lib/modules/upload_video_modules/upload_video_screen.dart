import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/utils/navigation_services.dart';
import 'package:videos_application/core/values/lang_keys.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_cubit/upload_video_cubit.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_cubit/upload_video_states.dart';
import 'package:videos_application/modules/videos_modules/video_player_screen.dart';
import 'package:videos_application/shared/widgets/custom_disable_widget.dart';
import 'package:videos_application/shared/widgets/my_text_form_field.dart';

import '../../core/values/cache_keys.dart';
import '../../core/values/constants.dart';
import '../../permission_cubit/permission_cubit.dart';
import '../../permission_cubit/permission_states.dart';

class UploadVideoScreen extends StatelessWidget {
  const UploadVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceHolder();
// <<<<<<< admin_panel_backup
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add New Video'),
//       ),
//       body: BlocProvider(
//         create: (context) => UploadVideoCubit(),
//         child: BlocConsumer<UploadVideoCubit, UploadVideoStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             UploadVideoCubit uploadVideoCubit = UploadVideoCubit.get(context);
//             return Form(
//               key: uploadVideoCubit.addPostFormKey,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MyTextFormField(
//                       label: 'title',
//                       controller: uploadVideoCubit.titleController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'title is required';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     MyTextFormField(
//                       label: 'content',
//                       controller: uploadVideoCubit.contentController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'content is required';
//                         }
//                         return null;
//                       },
//                     ),
//                     BlocConsumer<PermissionsCubit, PermissionsStates>(
//                         listener: (context, state) {},
//                         builder: (context, state) {
//                           PermissionsCubit permissionCubit =
//                               PermissionsCubit.get(context);
//                           return TextButton(
//                               onPressed: () async {
//                                 await permissionCubit.requestPermission(
//                                   context: context,
//                                   permissionType: PermissionType.video,
//                                   functionWhenGranted:
//                                       uploadVideoCubit.pickVideo,
//                                 );
//                                 print('before compress');
//                                 if (uploadVideoCubit.video != null) {
//                                   uploadVideoCubit.compressVideo(
//                                       uploadVideoCubit.video!.path);
//                                 }
//                                 print('after conmpress');
//                               },
//                               child: const Text('pick video'));
//                         }),
//                     ElevatedButton(
// =======
//     return BlocProvider(
//       create: (context) => UploadVideoCubit(),
//       child: BlocConsumer<UploadVideoCubit, UploadVideoStates>(
//         listener: (context, state) {
//           if (state is UploadVideoSuccessState) {
//             showToast(
//               meg: state.uploadVideoModel.message!,
//               toastState: state.uploadVideoModel.status == true
//                   ? ToastStates.success
//                   : ToastStates.error,
//             );
//           }
//         },
//         builder: (context, state) {
//           UploadVideoCubit uploadVideoCubit = UploadVideoCubit.get(context);
//           return Stack(
//             children: [
//               Scaffold(
//                 appBar: AppBar(
//                   title: Text(LangKeys.ADD_VIDEO_TITLE.tr()),
//                   actions: [
//                     IconButton(
// >>>>>>> main
//                       onPressed: () {
//                         NavigationServices.navigateTo(
//                             context, VideoPlayerScreen());
//                       },
// // <<<<<<< admin_panel_backup
// //                       child: const Text('add post with video'),
// // =======
//                       icon: Icon(Icons.video_collection),
// // >>>>>>> main
//                     ),
//                   ],
//                 ),
//                 body: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Form(
//                     key: uploadVideoCubit.addPostFormKey,
//                     child: ListView(
//                       children: [
//                         Card(
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 MyTextFormField(
//                                   label: LangKeys.ADD_VIDEO_TITLE_FIELD.tr(),
//                                   controller: uploadVideoCubit.titleController,
//                                   textInputAction: TextInputAction.next,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return LangKeys
//                                           .ADD_VIDEO_TITLE_FIELD_REQUIRED
//                                           .tr();
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 MyTextFormField(
//                                   label: LangKeys.ADD_VIDEO_CONTENT_FIELD.tr(),
//                                   controller:
//                                       uploadVideoCubit.contentController,
//                                   textInputAction: TextInputAction.done,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return LangKeys
//                                           .ADD_VIDEO_CONTENT_FIELD_REQUIRED
//                                           .tr();
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 16,
//                                 ),
//                                 BlocConsumer<PermissionsCubit,
//                                         PermissionsStates>(
//                                     listener: (context, state) {},
//                                     builder: (context, state) {
//                                       PermissionsCubit permissionCubit =
//                                           PermissionsCubit.get(context);
//                                       return ElevatedButton.icon(
//                                         onPressed: () async {
//                                           await permissionCubit
//                                               .requestPermission(
//                                             context: context,
//                                             permissionType:
//                                                 PermissionType.video,
//                                             functionWhenGranted:
//                                                 uploadVideoCubit.pickVideo,
//                                           );
//                                         },
//                                         icon: Icon(Icons.video_library),
//                                         label: Text(LangKeys
//                                             .ADD_VIDEO_PICK_VIDEO_BUTTON
//                                             .tr()),
//                                         style: ElevatedButton.styleFrom(
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       10)),
//                                         ),
//                                       );
//                                     }),
//                                 SizedBox(height: 8,),
//                                 Text(
//                                   uploadVideoCubit.video == null
//                                       ? ''
//                                       : uploadVideoCubit.video!.name,
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (uploadVideoCubit
//                                 .addPostFormKey.currentState!
//                                 .validate()) {
//                               uploadVideoCubit.addVideo(
//                                 title: uploadVideoCubit
//                                     .titleController.text,
//                                 content: uploadVideoCubit
//                                     .contentController.text,
//                                 videoFile:
//                                 uploadVideoCubit.mediaInfo != null
//                                     ? File(uploadVideoCubit
//                                     .mediaInfo!.path!)
//                                     : null,
//                                 // uploadVideoCubit.video != null
//                                 //     ? File(uploadVideoCubit.video!.path)
//                                 //     : null,
//                               );
//                             }
//                           },
//                           child: Text(
//                               LangKeys.ADD_VIDEO_ADD_VIDEO_BUTTON.tr()),
//                           style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: 8),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               state is UploadVideoLoadingState ||
//                       state is CompressVideoLoadingState
//                   ? CustomDisableWidget()
//                   : Container(),
//             ],
//           );
//         },
//       ),
//     );
  }
}
