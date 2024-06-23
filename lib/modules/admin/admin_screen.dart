import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/utils/navigation_services.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/modules/admin/cubit/admin_cubit.dart';
import 'package:videos_application/modules/admin/cubit/states.dart';
import 'package:videos_application/shared/widgets/custom_text_widget.dart';
import '../../core/presentation/Palette.dart';
import '../../core/values/lang_keys.dart';

List<String> adminOptions = [
  LangKeys.users,
  LangKeys.companies,
  LangKeys.ADVERTISMENTS,
  LangKeys.statistics,
];
List<IconData> adminIcons = [
  Icons.people_alt_sharp,
  Icons.business,
  Icons.add_to_home_screen,
  Icons.stacked_line_chart,
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
            backgroundColor: Palette.scaffoldBackground,
            body: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                child: GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: List.generate(adminOptions.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        NavigationServices.navigateTo(
                            context, cubit.screens[index]);
                      },
                      child: Card(
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    adminIcons[index],
                                    size: 26,
                                  ),
                                  vSpace(),
                                  DefaultText(
                                    text: adminOptions[index].tr(),
                                    style: context.textTheme.labelSmall!
                                        .copyWith(
                                            color: Palette.border,
                                            fontSize: 19),
                                  ),
                                ],
                              )),
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
