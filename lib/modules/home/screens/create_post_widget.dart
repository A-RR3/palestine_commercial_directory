import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_compress/video_compress.dart';
import 'package:palestine_commercial_directory/core/utils/extensions.dart';
import 'package:palestine_commercial_directory/core/utils/navigation_services.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/home_cubit.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/posts_cubit.dart';
import 'package:palestine_commercial_directory/permission_cubit/permission_cubit.dart';
import 'package:palestine_commercial_directory/permission_cubit/permission_states.dart';
import '../../../core/presentation/Palette.dart';
import '../../../core/values/cache_keys.dart';
import '../../../core/values/constants.dart';
import '../../../shared/network/remote/end_points.dart';
import '../../../shared/widgets/custom_material_botton_widget.dart';
import '../../../shared/widgets/custom_text_widget.dart';

class PostScreen extends StatefulWidget {
  PostsCubit postsCubit;
  FocusScopeNode? focusNode;
  // String userImage;
  PostScreen(this.postsCubit, this.focusNode);
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _contentArController = TextEditingController();
  XFile? _mediaImage;
  ImagePicker? _picker;
  String? _mediaType;
  MediaInfo? mediaInfo;
  Subscription? _subscription;
  double? progress;
  bool isCompressing = false;
  double? value;
  FocusNode? _focusNode;
  FocusScopeNode? _focusScopeNode;
  HomeCubit? homeCubit;

  @override
  void initState() {
    print('init sate');
    _picker = ImagePicker();
    _focusNode = FocusNode();
    _focusScopeNode = this._focusScopeNode;

    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      setState(() {
        this.progress = progress;
        print('ww---\n');
      });
    });
    homeCubit = HomeCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    _contentArController.dispose();
    _contentController.dispose();
    _focusNode?.dispose();
    _focusScopeNode?.dispose();
    VideoCompress.cancelCompression();
    _subscription?.unsubscribe();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      value = progress == null ? progress : progress! / 100;
    });

    super.didChangeDependencies();
  }

  // String? compressedVideoPath;

  Future showLoadingDialog() => showDialog(
        context: this.context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(child: ProgressDialogWidget);
        },
      );

  Future<void> compressVideo(File videoFile) async {
    print('original file path: ${videoFile.path}');

    showLoadingDialog();
    await VideoCompress.deleteAllCache();
    await VideoCompress.setLogLevel(0);
    try {
      await VideoCompress.compressVideo(
        videoFile.path,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false,
        includeAudio: true,
      ).then((value) {
        setState(() {
          isCompressing = false;
          mediaInfo = value;
        });
        print('_mediaType$_mediaType');
        print('final path after compress: ${mediaInfo?.path}');
      }).catchError((error) {
        VideoCompress.cancelCompression();
        debugPrint(error.toString());
      });
    } finally {
      print('image$_mediaImage\ntype:$_mediaType\nmediaInfo:$mediaInfo');
      NavigationServices.back(this.context);
    }
  }

  Future<void> _pickMedia(
      ImageSource source, String mediaType, BuildContext context) async {
    //pick Xfile
    final pickedFile = await (mediaType == 'image'
        ? _picker?.pickImage(
            source: source, maxWidth: 400, maxHeight: 400, imageQuality: 50)
        : _picker?.pickVideo(source: source));

    if (pickedFile != null) {
      if (mediaType == 'video') {
        print('file path${pickedFile.path}');
        await compressVideo(File(pickedFile.path));
        print('compressed');
      } else {
        _mediaImage = pickedFile;
      }
      setState(() {
        _mediaType = mediaType;
      });
    } else {
      _mediaType = null;
    }
  }

  void _postContent() async {
    if (_contentController.text.isEmpty &&
        _mediaImage == null &&
        mediaInfo == null) {
      _mediaType = null;
      showToast(
          meg: 'Please enter some content or select a media file',
          toastState: ToastStates.warning,
          color: Colors.black);
    }
    print('image$_mediaImage\ntype:$_mediaType\nmediaInfo:$mediaInfo');
    widget.postsCubit.createPost(
        _mediaImage, _mediaType, mediaInfo, _contentController.text);
    _contentArController.text = 'منشور باللغة العربية';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermissionsCubit, PermissionsStates>(
      builder: (context, state) {
        PermissionsCubit permissionsCubit = PermissionsCubit.get(context);
        GlobalKey<FormState> formKey = GlobalKey<FormState>();
        return FocusScope(
            node: _focusScopeNode,
            child: Container(
              color: Palette.scaffoldAppBarColor,
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          homeCubit!.user!.uImage != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${EndPointsConstants.usersStorage}${homeCubit!.user!.uImage!}'), // Replace with your avatar image
                                  radius: 20,
                                )
                              : defaultContainer(
                                  height: 40,
                                  width: 40,
                                  child: defaultPersonImage,
                                  hasShadow: true),
                          hSpace(10),
                          Expanded(
                              child: Form(
                            key: formKey,
                            child: TextFormField(
                              focusNode: _focusNode,
                              controller: _contentController,
                              onChanged: (value) =>
                                  _contentController.text = value,
                              decoration: InputDecoration(
                                hintText: "What's on your mind?",
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                            ),
                          )),
                        ],
                      ),
                      vSpace(10),
                      if (_mediaImage != null)
                        _mediaType == 'image'
                            // ? Image.file(File(_mediaImage!.path))
                            ? Text(_mediaImage!.path.split('/').last)
                            : _mediaType == 'video'
                                ? Text('Video selected: ${mediaInfo!.path!}')
                                : Text(''),
                      Divider(thickness: 1, color: Colors.grey[300]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                mediaInfo = null;
                              });
                              permissionsCubit.requestPermission(
                                  context: context,
                                  permissionType: PermissionType.photo,
                                  functionWhenGranted: () => _pickMedia(
                                      ImageSource.gallery, 'image', context));
                            },
                            icon: Icon(Icons.photo, color: Colors.green),
                            label: DefaultText(
                              text: 'image',
                              style: context.textTheme.headlineSmall!
                                  .copyWith(fontSize: 20),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _mediaImage = null;
                              });
                              permissionsCubit.requestPermission(
                                  context: context,
                                  permissionType: PermissionType.video,
                                  functionWhenGranted: () => _pickMedia(
                                      ImageSource.gallery, 'video', context));
                            },
                            icon: Icon(Icons.video_call, color: Colors.red),
                            label: DefaultText(
                              text: 'Video',
                              style: context.textTheme.headlineSmall!
                                  .copyWith(fontSize: 20),
                            ),
                          ),
                          CustomMaterialBotton(
                            height: 15,
                            width: 20,
                            onPressed: () {
                              setState(() {
                                _focusNode?.dispose();
                                _focusNode = FocusNode();
                              });
                              _postContent();
                            },
                            hasPadding: true,
                            color: Colors.blue[800],
                            child: DefaultText(
                              text: 'Post',
                              style: context.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
      listener: (context, state) {},
    );
  }

  Widget get ProgressDialogWidget {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Compressing Video ...',
            style: TextStyle(fontSize: 20),
          ),
          vSpace(24),
          LinearProgressIndicator(
            value: value,
            minHeight: 12,
          ),
          vSpace(16),
          ElevatedButton(
              onPressed: () => VideoCompress.cancelCompression(),
              child: Text('Cancel'))
        ],
      ),
    );
  }
}
