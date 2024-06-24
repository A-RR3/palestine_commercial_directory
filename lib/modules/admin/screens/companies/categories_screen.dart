import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/admin/screens/companies/cubit/companies_cubit.dart';
import 'package:videos_application/modules/admin/screens/companies/cubit/companies_states.dart';
import 'package:videos_application/shared/widgets/default_app_bar.dart';
import '../../../../core/values/lang_keys.dart';
import '../../../../shared/widgets/my_search_bar.dart';
import '../../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: LangKeys.categories.tr(),
        ),
        body: BlocProvider(
          create: (BuildContext context) =>
              CompaniesCubit()..getCategoriesData(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: BlocConsumer<CompaniesCubit, CompaniesStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  CompaniesCubit cubit = CompaniesCubit.get(context);
                  if (state is CategoriesLoadingDataState ||
                      state is CompaniesInitialState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // MySearchBar(
                          //   hint: "Search Category",
                          //   onChanged: (value) => {},
                          // ),
                          Expanded(
                              child: GridView.builder(
                            itemCount: cubit.categories!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 2,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return CategoryItem(
                                category: cubit.categories![index],
                                cubit: cubit,
                              );
                            },
                          ))
                        ],
                      ),
                    );
                  }
                },
              )),
        ));
  }
}
