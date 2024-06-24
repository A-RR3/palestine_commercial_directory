import 'package:easy_localization/easy_localization.dart' as easy hide LTR;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/values/cache_keys.dart';
import 'package:videos_application/core/values/lang_keys.dart';
import 'package:videos_application/modules/admin/admin_screen.dart';
import 'package:videos_application/modules/home/cubit/home_cubit.dart';
import 'package:videos_application/modules/home/screens/home_screen_view.dart';
import 'package:videos_application/modules/home/screens/owner_view.dart';
import 'package:videos_application/shared/widgets/default_app_bar.dart';
import '../../core/presentation/Palette.dart';
import '../../core/values/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/widgets/custom_drawer.dart';
import 'cubit/home_states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit()
          ..getSingleUserById(CacheHelper.getData(CacheKeys.userId.name)),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is UserLoggedOutSuccessfully) {
              showToast(meg: state.message, toastState: ToastStates.success);
            }
          },
          builder: (context, state) {
            HomeCubit homeCubit = HomeCubit.get(context);
            bool isLogged = CacheHelper.getBool(CacheKeys.isLogged.name);
            print(isLogged);
            return Scaffold(
                key: _scaffoldKey,
                drawer: CustomDrawer(cubit: homeCubit),
                backgroundColor: (state is ChangeAppLangLoadingStateState)
                    ? Colors.black54.withOpacity(.3)
                    : Palette.scaffoldBackground,
                appBar: DefaultAppBar(
                  withDrawer: true,
                  isHomePage: true,
                  title: LangKeys.HOME_SCREEN.tr(),
                ),
                body: (state is ChangeAppLangLoadingStateState ||
                        state is GetCurrentUserDataInitialState)
                    ? const Center(child: CircularProgressIndicator())
                    : (!isLogged)
                        ? const HomeView()
                        : homeCubit.user?.uRoleId == 1
                            ? const AdminPanel()
                            : CompanyOwnerView(
                                userId: homeCubit.user?.uId,
                              ));
          },
        ));
  }
}
