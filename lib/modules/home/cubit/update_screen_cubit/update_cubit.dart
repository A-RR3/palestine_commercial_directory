import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/models/login_model.dart';
import 'package:videos_application/modules/home/cubit/home_cubit.dart';
import 'package:videos_application/modules/home/cubit/update_screen_cubit/update_user_states.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';

import '../../../../core/values/cache_keys.dart';
import '../../../../core/values/constants.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/network/remote/end_points.dart';
import 'package:http_parser/http_parser.dart';

class UpdateCubit extends Cubit<UpdateStates> {
  UpdateCubit() : super(UpdateInitialState());

  static UpdateCubit get(context) => BlocProvider.of(context);

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();
  bool isImageSelected = false;
  XFile? selectedImage;
  // bool? isImageRemoved;

  void fillInitialUserData(String name, String phone) {
    phoneController.text = phone;
    nameController.text = name;
  }

  LoginModel? data;

  void updateUser(int id, HomeCubit homeCubit) async {
    emit(UpdateUserDataLoadingState());
    String phone = phoneController.text;
    String nameEn = homeCubit.user!.uName!;
    String nameAr = homeCubit.user!.uNameAr!;
    String name = nameController.text;
    int roleId = homeCubit.user!.uRoleId!;
    // String? uImage;

    bool isLocaleEn = CacheHelper.getData(CacheKeys.lang.name) == enCode;

    // if (homeCubit.user?.uImage != null) {
    //   uImage = '${EndPointsConstants.usersStorage}${homeCubit.user?.uImage}';
    // }

    //if the user submitted an empty fields get the data from cache
    if (phoneController.text.isEmpty) {
      phone = homeCubit.user!.uPhone!;
    }
    if (nameController.text.isEmpty) {
      name = isLocaleEn ? nameEn : nameAr;
    }
//update the locally stored data for the user
    isLocaleEn
        ? homeCubit.user?.uName != name
        : homeCubit.user!.uNameAr != name;
    homeCubit.user!.uPhone != phone;

    //image
    print('isImageSelected: ${isImageSelected}');
    print('selectedImage: ${selectedImage}');

    FormData? formData;
    if (isImageSelected) {
      formData = FormData.fromMap({
        'id': id,
        'name_en': isLocaleEn ? name : nameEn,
        'name_ar': isLocaleEn ? nameAr : name,
        'phone': phone.toString(),
        'image': await MultipartFile.fromFile(selectedImage!.path,
            filename: selectedImage!.name,
            contentType: MediaType.parse(
                selectedImage!.mimeType ?? 'application/octet-stream')),
        'role': roleId
      });
    } else {
      formData = FormData.fromMap({
        'id': id,
        'name_en': isLocaleEn ? name : nameEn,
        'name_ar': isLocaleEn ? nameAr : name,
        'phone': phone.toString(),
        'role': roleId
      });
    }

    await DioHelper.postData(
            url: 'update',
            token: userToken,
            data: formData,
            contentType: 'multipart/form-data')
        .then((response) {
      data = LoginModel.fromJson(response?.data);
      print(data);
      emit(UpdateUserDataSuccessState(data!.message));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  final ImagePicker _picker = ImagePicker();
  void pickImage() async {
    var pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500,
        maxWidth: 500);

    if (pickedFile != null) {
      isImageSelected = true;
      selectedImage = pickedFile;
      emit(ImageUploadedSuccessfullyState());
      print('xfile: ${pickedFile}');
      print('xfile path: ${pickedFile.path}');
      print('xfile name: ${pickedFile.name}');
      print('xfile mime: ${pickedFile.mimeType}');
    } else {
      print('No image selected.');
    }
  }
}
