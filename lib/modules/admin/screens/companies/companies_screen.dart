import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/values/constants.dart';
import 'package:palestine_commercial_directory/core/values/lang_keys.dart';
import 'package:palestine_commercial_directory/models/company_model.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/companies/cubit/companies_cubit.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/companies/cubit/companies_states.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/companies/widgets/company_list_item.dart';
import 'package:palestine_commercial_directory/shared/widgets/default_app_bar.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen(
      {super.key, required this.categoryId, required this.cubit});

  final int categoryId;
  final CompaniesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: LangKeys.companies.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [
              Expanded(
                  child: BlocProvider.value(
                      value: cubit,
                      child: BlocConsumer<CompaniesCubit, CompaniesStates>(
                          listener: (context, cState) {},
                          builder: (context, cState) {
                            CompaniesCubit cubit = CompaniesCubit.get(context);

                            if (cState is CompaniesInitialState) {
                              return const SizedBox();
                            } else {
                              return ListView.separated(
                                  itemBuilder: (context, index) {
                                    CompanyModel company =
                                        cubit.companies[index];
                                    return CompanyItemWidget(company);
                                  },
                                  separatorBuilder: (context, index) =>
                                      vSpace(),
                                  itemCount: cubit.companies.length);
                            }
                          })))
            ],
          ),
        ));
  }
}
