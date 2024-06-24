import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/core/values/lang_keys.dart';
import 'package:videos_application/modules/home/cubit/home_cubit.dart';
import 'package:videos_application/modules/home/cubit/update_screen_cubit/update_cubit.dart';
import 'package:videos_application/modules/home/cubit/update_screen_cubit/update_user_states.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';
import 'package:videos_application/shared/widgets/custom_material_botton_widget.dart';
import 'package:videos_application/shared/widgets/custom_text_widget.dart';
import 'package:videos_application/shared/widgets/custome_text_form_field_widget.dart';
import 'package:videos_application/shared/widgets/default_app_bar.dart';
import '../../../core/values/asset_keys.dart';
import '../../../core/values/cache_keys.dart';
import '../../../shared/network/remote/end_points.dart';

class UpdateUserDataScreen extends StatelessWidget {
  const UpdateUserDataScreen({super.key, this.userId, required this.homeCubit});
  final int? userId;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    bool isLocaleEn = CacheHelper.getData(CacheKeys.lang.name) == enCode;
    return Scaffold(
      appBar: DefaultAppBar(title: ''),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BlocProvider(
                create: (context) => UpdateCubit()
                  ..fillInitialUserData(
                      isLocaleEn
                          ? homeCubit.user!.uName!
                          : homeCubit.user!.uNameAr!,
                      homeCubit.user!.uPhone!),
                child: BlocConsumer<UpdateCubit, UpdateStates>(
                  listener: (context, state) async {
                    // if (state is UpdateInitialState) {
                    //   if (!kIsWeb &&
                    //       defaultTargetPlatform == TargetPlatform.android) {
                    //     UpdateCubit updateCubit = UpdateCubit.get(context);
                    //     await updateCubit.retrieveLostData();
                    //   }
                    // }
                    if (state is UpdateUserDataSuccessState) {
                      showToast(
                          meg: state.message, toastState: ToastStates.success);
                      homeCubit.getSingleUserById(homeCubit.user!.uId);
                    }
                  },
                  builder: (context, state) {
                    UpdateCubit updateCubit = UpdateCubit.get(context);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(75),
                                  ),
                                  child: updateCubit.selectedImage == null
                                      ? homeCubit.user?.uImage != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                '${EndPointsConstants.usersStorage}${homeCubit.user?.uImage}',
                                                fit: BoxFit.cover,
                                              ))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: SvgPicture.asset(
                                                AssetsKeys.getIconPath(
                                                    AssetsKeys.DEFAULT_PERSON),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.file(
                                              File(updateCubit
                                                  .selectedImage!.path),
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                            return const Center(
                                                child: Text(
                                                    'This image type is not supported'));
                                          }, fit: BoxFit.cover))),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 50,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(150)),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.photo_camera,
                                        color: Colors.white),
                                    onPressed: updateCubit.pickImage,
                                  ),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: context.deviceSize.height * .4,
                          child: Form(
                              key: updateCubit.updateFormKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomTextFormField(
                                    controller: updateCubit.phoneController,
                                    labelText: LangKeys.USER_PHONE.tr(),
                                    textInputType: TextInputType.text,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.5)),
                                    fillColor: Colors.black38.withOpacity(.2),
                                    focusNode: updateCubit.phoneFocusNode,
                                    onFieldSubmitted: (p0) =>
                                        FocusScope.of(context).requestFocus(
                                            updateCubit.nameFocusNode),
                                  ),
                                  CustomTextFormField(
                                    controller: updateCubit.nameController,
                                    labelText: LangKeys.USER_NAME.tr(),
                                    textInputType: TextInputType.text,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.5)),
                                    fillColor: Colors.black38.withOpacity(.2),
                                    focusNode: updateCubit.nameFocusNode,
                                  ),
                                  CustomMaterialBotton(
                                    onPressed: () {
                                      updateCubit.updateUser(
                                          homeCubit.user!.uId!, homeCubit);
                                      FocusScope.of(context).unfocus();
                                      // homeCubit.getSingleUserById(
                                      //     homeCubit.user!.uId!);
                                    },
                                    color: Colors.blueGrey,
                                    child: const DefaultText(text: 'Update'),
                                  )
                                ],
                              )),
                        )
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
