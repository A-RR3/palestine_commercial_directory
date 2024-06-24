import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:videos_application/core/presentation/Palette.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/values/lang_keys.dart';
import 'package:videos_application/models/company_model.dart';

import '../../../../../core/values/cache_keys.dart';
import '../../../../../core/values/constants.dart';
import '../../../../../shared/network/local/cache_helper.dart';
import '../../../../../shared/widgets/custom_text_widget.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_states.dart';
import 'google_map_widget.dart';

class CompanyItemWidget extends StatelessWidget {
  CompanyItemWidget(this.company, {super.key})
      : _companyLat = LatLng(company.latitude!, company.logitude!);
  CompanyModel company;
  LatLng _companyLat;

  @override
  Widget build(BuildContext context) {
    String lang = CacheHelper.getData(CacheKeys.lang.name);

    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            isScrollControlled: true,
            useSafeArea: true,
            elevation: 4,
            // enableDrag: true,
            builder: (context) {
              return BlocProvider(
                create: (context) =>
                    LocationCubit()..checkLocationServiceIsEnabled(context),
                child: Container(
                    height: context.deviceSize.height,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DefaultText(
                                  text: LangKeys.Location.tr(),
                                  style: context.textTheme.headlineMedium,
                                ),
                                vSpace(30),
                                _sheetContent(context)
                              ],
                            )))),
              );
            },
          );
        },
        child: Center(
          child: ListTile(
              style: ListTileStyle.drawer,
              minTileHeight: 20,
              titleAlignment: ListTileTitleAlignment.center,
              minVerticalPadding: 0,
              title: Text(
                lang == enCode ? company!.cName! : company!.cNameAR!,
                style: context.textTheme.headlineSmall!.copyWith(fontSize: 23),
              ),
              subtitle: DefaultText(
                text: lang == enCode
                    ? '''\n${LangKeys.ownerName.tr(namedArgs: {
                            'name': '${company.ownerName}',
                          })}\n${LangKeys.companyPhone.tr(namedArgs: {
                            'phone': '${company.cPhone}'
                          })}'''
                    : '''${LangKeys.ownerName.tr(namedArgs: {
                            'name': '${company.ownerNameAr}',
                          })}\n${LangKeys.companyPhone.tr(namedArgs: {
                            'phone': '${company.cPhone}'
                          })}''',
                color: Palette.adminPageIconsColor,
              )),
        ));
  }

  _sheetContent(BuildContext context) => Container(
      height: context.deviceSize.height * .6,
      width: double.infinity,
      child: BlocConsumer<LocationCubit, LocationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LocationCubit locationCubit = LocationCubit.get(context);
          locationCubit.companyLocation = _companyLat;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => locationCubit.onPressOrigin(),
                      child: DefaultText(
                        text: 'origin',
                        color: Palette.scaffoldAppBarColor,
                      )),
                  TextButton(
                      onPressed: () => locationCubit.onPressDestination(),
                      child: DefaultText(
                        text: 'company',
                        color: Palette.scaffoldAppBarColor,
                      ))
                ],
              ),
              Expanded(
                  child: locationCubit.currentP == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GoogleMapWidget(
                          companyLat: _companyLat,
                          locationCubit: locationCubit,
                        ))
            ],
          );
        },
      ));
}
