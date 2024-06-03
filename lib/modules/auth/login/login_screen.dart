import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/values/asset_keys.dart';
import 'package:videos_application/core/values/cache_keys.dart';
import 'package:videos_application/modules/auth/login/widgets/gradient_text_widget.dart';
import 'package:videos_application/modules/admin/admin_screen.dart';
import 'package:videos_application/modules/home/home_screen.dart';
import 'package:videos_application/modules/home/owner_view.dart';
import '../../../core/presentation/fonts.dart';
import '../../../core/utils/navigation_services.dart';
import '../../../core/utils/validation_utils.dart';
import '../../../core/values/constants.dart';
import '../../../core/values/lang_keys.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/widgets/custom_material_botton_widget.dart';
import '../../../shared/widgets/custome_text_form_field_widget.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var loginFormKey = GlobalKey<FormState>();
  var userPhoneController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if (state is LoginSuccessState) {
            if (state.profileModel.status) {
              print(state.profileModel.token!);

              CacheHelper.setData(
                      key: CacheKeys.token.name,
                      value: state.profileModel.token!)
                  .then((value) async {
                userToken = state.profileModel.token!;
                await CacheHelper.setData(
                    key: CacheKeys.isLogged.name, value: true);
                isLogged = true;
                await CacheHelper.setData(
                    key: CacheKeys.userId.name,
                    value: state.profileModel.user!.id);
                userId = state.profileModel.user!.id;
                await CacheHelper.setData(
                    key: CacheKeys.userRole.name,
                    value: state.profileModel.user!.role);
                userRole = state.profileModel.user!.role;
                showToast(
                    meg: state.profileModel.message!,
                    toastState: ToastStates.success);
                NavigationServices.navigateTo(context, HomeScreen(),
                    removeAll: true);
              });
            } else {
              showToast(
                  meg: state.profileModel.message!,
                  toastState: ToastStates.error);
            }
          }
        },
        builder: (BuildContext context, LoginStates state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Builder(builder: (context) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                        child: Opacity(
                      opacity: .5,
                      child: Image.asset(
                        AssetsKeys.getImagePath(AssetsKeys.LOGIN_SCREEN_IMG,
                            extension: 'jpg'),
                        fit: BoxFit.cover,
                      ),
                    )),
                    SafeArea(
                      child: SizedBox(
                        width: deviceSize.width,
                        child: SingleChildScrollView(
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                vSpace(40),
                                SizedBox(
                                  height: deviceSize.height * .3,
                                  width: deviceSize.height * .3,
                                  child: Image.asset(AssetsKeys.getImagePath(
                                      AssetsKeys.SPLASH_SCREEN_IMG)),
                                ),
                                GradientText(
                                  text: LangKeys.OPENING_STATEMENT.tr(),
                                  gradient: const LinearGradient(colors: [
                                    Colors.blueAccent,
                                    Colors.pinkAccent,
                                    Color(0xff623663),
                                  ]),
                                  style: const TextStyle(
                                      fontSize: 36,
                                      fontFamily: Fonts.manropeMedium,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white60),
                                ),
                                vSpace(20),
                                SizedBox(
                                  height: deviceSize.height * .4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Form(
                                      key: loginFormKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          vSpace(),
                                          CustomTextFormField(
                                            controller: userPhoneController,
                                            textInputType: TextInputType.number,
                                            validator: (value) =>
                                                ValidationUtils.validateIsEmpty(
                                                    value,
                                                    LangKeys.ENTER_PHONE.tr()),
                                            hintText: LangKeys.USER_PHONE.tr(),
                                            prefixIcon: Icons.phone,
                                            border: loginInputBorder,
                                            focusNode: loginCubit.phoneFocus,
                                            onFieldSubmitted: (p0) =>
                                                FocusScope.of(context)
                                                    .requestFocus(loginCubit
                                                        .passwordFocus),
                                            textInputAction:
                                                TextInputAction.next,
                                            filled: true,
                                          ),
                                          vSpace(),
                                          CustomTextFormField(
                                              controller: passwordController,
                                              textInputType:
                                                  TextInputType.visiblePassword,
                                              obscureText:
                                                  !loginCubit.isPasswordShown,
                                              validator: (value) =>
                                                  ValidationUtils
                                                      .validateIsEmpty(
                                                          value,
                                                          LangKeys
                                                              .ENTER_PASSWORD
                                                              .tr()),
                                              hintText:
                                                  LangKeys.USER_PASSWORD.tr(),
                                              prefixIcon: Icons.lock_outline,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  loginCubit.showHidePassword(
                                                      ChangePasswordVisibilityState());
                                                },
                                                icon: loginCubit.passwordIcon,
                                              ),
                                              textInputAction:
                                                  TextInputAction.done,
                                              focusNode:
                                                  loginCubit.passwordFocus,
                                              border: loginInputBorder),
                                          const Expanded(child: SizedBox()),
                                          CustomMaterialBotton(
                                            onPressed: () {
                                              if (loginFormKey.currentState!
                                                  .validate()) {
                                                loginCubit.userLogin(
                                                    phone: userPhoneController
                                                        .text,
                                                    password: passwordController
                                                        .text);
                                              }
                                              FocusScope.of(context).unfocus();
                                            },
                                            height: 50,
                                            child: state is LoginLoadingState
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Text(
                                                    LangKeys.LOGIN.tr(),
                                                    style: context
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // const Spacer()
                              ]),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
