import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos_application/core/presentation/Palette.dart';
import 'package:videos_application/core/utils/navigation_services.dart';
import 'package:videos_application/core/values/lang_keys.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Palette.primaryColor,
            ),
            child: Text(
              'user name / or phone',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.video_call),
            title: Text(LangKeys.DRAWER_VIDEOS.tr()),
            onTap: () {
              NavigationServices.navigateTo(context, UploadVideoScreen());
            },
          ),
        ],
      ),
    );
  }
}
