import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:palestine_commercial_directory/permission_cubit/permission_states.dart';

// convert to mixin
// in utils/mixins folder

enum PermissionType { photo, video, location }

class PermissionsCubit extends Cubit<PermissionsStates> {
  PermissionsCubit() : super(PermissionsInitialState());

  static PermissionsCubit get(context) => BlocProvider.of(context);

  PermissionStatus? permissionStatus;

  Future<void> requestPermission({
    required BuildContext context,
    required PermissionType permissionType,
    Future<void> Function()? functionWhenGranted,
  }) async {
    permissionStatus = null;
    print('requestPermission');
    print('permissionType: $permissionType');
    switch (permissionType) {
      case PermissionType.photo:
      case PermissionType.video:
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        if (deviceInfo.version.sdkInt > 32) {
          // Android version is greater than 32 (Android 13 or higher)
          // permissionStatus = await Permission.manageExternalStorage.request();
          if (permissionType == PermissionType.photo) {
            permissionStatus = await Permission.photos.request();
            print('photo');
          } else if (permissionType == PermissionType.video) {
            permissionStatus = await Permission.videos.request();
            print('video');
          }
          print('storage permission requested for > 32');
        } else {
          permissionStatus = await Permission.storage.request();
          print('storage permission requested for < 32');
        }
        break;
      case PermissionType.location:
        permissionStatus = await Permission.location.request();
        print('location permission requested');
        break;
    }

    print('permissionStatus: $permissionStatus');
    print('isPermanentlyDenied: ${permissionStatus?.isPermanentlyDenied}');

    if (permissionStatus?.isGranted == true) {
      // Permission granted, proceed to use the image picker
      print('${permissionType.toString()} permission granted');
      if (functionWhenGranted != null) {
        await functionWhenGranted();
      }
    } else if (permissionStatus?.isDenied == true) {
      print('${permissionType.toString()} permission denied');

      // Permission denied, show an explanation and request again
      showPermissionDeniedDialog(context);
    }
    // You can handle other status cases such as `isPermanentlyDenied` or `isRestricted`
  }

  Future<void> showPermissionDeniedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("permission_denied"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("permission_needed"),
            TextButton(
              onPressed: () {
                // openAppSettings();
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('permission_go_to_settings'),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("exit"),
          ),
        ],
      ),
    );
  }
}
