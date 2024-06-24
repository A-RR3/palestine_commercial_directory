import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/shared/widgets/custom_material_botton_widget.dart';
import '../../core/presentation/Palette.dart';
import '../../core/utils/navigation_services.dart';
import '../../core/values/asset_keys.dart';
import '../../core/values/cache_keys.dart';
import '../../core/values/constants.dart';
import '../../core/values/lang_keys.dart';
import '../../modules/auth/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'custom_text_widget.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  DefaultAppBar(
      {super.key,
      this.withDrawer = false,
      this.isHomePage = false,
      required this.title})
      : isLogged = CacheHelper.getBool(CacheKeys.isLogged.name);
  final bool withDrawer;
  final bool isHomePage;
  final String title;
  final bool isLogged;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: withDrawer
          ? Builder(
              builder: (context) {
                return IconButton(
                    icon: SvgPicture.asset(
                      AssetsKeys.getIconPath(AssetsKeys.Menu_ICON),
                      color: Colors.white,
                      width: 30,
                      height: 25,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer());
              },
            )
          : null,
      flexibleSpace: appBarGradient,
      elevation: 3,
      centerTitle: true,
      title: DefaultText(
        text: title,
        style: context.textTheme.headlineMedium!
            .copyWith(color: Palette.scaffoldBackground, fontSize: 25),
      ),
      actions: [
        isHomePage
            ? !isLogged
                ? SizedBox(
                    width: context.deviceSize.width * .23,
                    child: Center(
                      child: CustomMaterialBotton(
                        height: 25,
                        onPressed: () {
                          NavigationServices.navigateTo(
                              context, const LoginScreen());
                        },
                        hasPadding: false,
                        color: Palette.black.withOpacity(.2),
                        child: Text(
                          LangKeys.LOGIN.tr(),
                          style: context.textTheme.headlineSmall!
                              .copyWith(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ))
                : const Text('')
            : const SizedBox()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
