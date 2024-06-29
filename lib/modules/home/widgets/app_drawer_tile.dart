import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:palestine_commercial_directory/core/utils/extensions.dart';
import 'package:palestine_commercial_directory/core/values/constants.dart';

import '../../../core/presentation/Palette.dart';
import '../../../shared/widgets/custom_text_widget.dart';

class AppDrawerTile extends StatelessWidget {
  const AppDrawerTile({super.key, required this.index, required this.onTap});
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        minTileHeight: 20,
        tileColor: Palette.scaffoldBackground,
        leading: Icon(
          DrawerConstants.drawerItemIcon[index],
          size: 27,
          color: DrawerConstants.drawerItemColorIcon,
        ),
        title: DefaultText(
          text: DrawerConstants.drawerItemText[index].tr(),
          style: context.textTheme.headlineSmall!.copyWith(fontSize: 22),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 15,
        ),
        hoverColor: Colors.grey,
        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        onTap: onTap,
      ),
    );
  }
}
