import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/utils/navigation_services.dart';
import 'package:videos_application/modules/admin/cubit/admin_cubit.dart';
import 'package:videos_application/modules/admin/cubit/states.dart';
import 'package:videos_application/shared/widgets/custom_drawer.dart';
import '../../core/presentation/Palette.dart';
import '../../core/values/lang_keys.dart';

List<String> adminOptions = [
  LangKeys.USERS.tr(),
  LangKeys.COMPANIES.tr(),
  LangKeys.ADVERTISMENTS.tr(),
  LangKeys.STATISTICS.tr(),
];

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AdminCubit cubit = AdminCubit.get(context);

        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xffEDF8F9),
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text(LangKeys.ADMIN_PANEL.tr()),
              backgroundColor: Palette.primaryColor,
              bottomOpacity: 20,
              elevation: 5,
            ),
            body: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: GridView.count(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: List.generate(adminOptions.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        NavigationServices.navigateTo(
                            context, cubit.screens[index]);
                      },
                      child: Card(
                        // color: Palette.primaryColor,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                            child: Text(
                              adminOptions[index],
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
