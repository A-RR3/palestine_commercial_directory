import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/utils/extensions.dart';
import 'package:palestine_commercial_directory/core/values/asset_keys.dart';
import 'package:palestine_commercial_directory/core/values/cache_keys.dart';
import 'package:palestine_commercial_directory/modules/auth/login/widgets/gradient_text_widget.dart';
import 'package:palestine_commercial_directory/modules/home/home_screen.dart';
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
  const LoginScreen({super.key});

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
                await CacheHelper.setData(
                    key: CacheKeys.userId.name,
                    value: state.profileModel.user!.uId);
                userId = state.profileModel.user!.uId;
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
          loginCubit.isBottonDisabled = (state is LoginLoadingState ||
                  state is ChangeLoginButtonDisabledState)
              ? true
              : false;

          return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      AssetsKeys.getImagePath(AssetsKeys.LOGIN_SCREEN_IMG,
                          extension: 'jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Builder(builder: (context) {
                      return SafeArea(
                        child: SizedBox(
                          width: deviceSize.width,
                          height: deviceSize.height,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    vSpace(40),
                                    logo(context),
                                    vSpace(),

                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 20.0,
                                      ),
                                      child: gradientColorText,
                                    ),
                                    SizedBox(
                                      height: deviceSize.height * .7,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Form(
                                          key: loginCubit.loginFormKey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              vSpace(),
                                              CustomTextFormField(
                                                controller: loginCubit
                                                    .userPhoneController,
                                                textInputType:
                                                    TextInputType.number,
                                                validator: (value) =>
                                                    ValidationUtils
                                                        .validateIsEmpty(
                                                            value,
                                                            LangKeys.ENTER_PHONE
                                                                .tr()),
                                                hintText:
                                                    LangKeys.USER_PHONE.tr(),
                                                prefixIcon: Icons.phone,
                                                border: loginInputBorder,
                                                focusNode:
                                                    loginCubit.phoneFocus,
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
                                                  controller: loginCubit
                                                      .passwordController,
                                                  textInputType: TextInputType
                                                      .visiblePassword,
                                                  obscureText: !loginCubit
                                                      .isPasswordShown,
                                                  validator: (value) =>
                                                      ValidationUtils
                                                          .validateIsEmpty(
                                                              value,
                                                              LangKeys
                                                                  .ENTER_PASSWORD
                                                                  .tr()),
                                                  hintText:
                                                      LangKeys
                                                          .USER_PASSWORD
                                                          .tr(),
                                                  prefixIcon:
                                                      Icons.lock_outline,
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      loginCubit.showHidePassword(
                                                          ChangePasswordVisibilityState());
                                                    },
                                                    icon:
                                                        loginCubit.passwordIcon,
                                                  ),
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  focusNode:
                                                      loginCubit.passwordFocus,
                                                  border: loginInputBorder),
                                              const Spacer(),
                                              testData(context, loginCubit),
                                              CustomMaterialBotton(
                                                onPressed: loginCubit
                                                        .isBottonDisabled
                                                    ? null
                                                    : () {
                                                        if (loginCubit
                                                            .loginFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          loginCubit.userLogin(
                                                              phone: loginCubit
                                                                  .userPhoneController
                                                                  .text,
                                                              password: loginCubit
                                                                  .passwordController
                                                                  .text);
                                                        }
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      },
                                                height: 50,
                                                child: (state
                                                        is LoginLoadingState)
                                                    ? const CircularProgressIndicator()
                                                    : Text(
                                                        LangKeys.LOGIN.tr(),
                                                        style: context.textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                              ),
                                              const Spacer(
                                                flex: 2,
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
                        ),
                      );
                    }),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget logo(BuildContext context) => SizedBox(
        height: context.deviceSize.height * .18,
        width: context.deviceSize.height * .3,
        child: Image.asset(
          AssetsKeys.getImagePath(AssetsKeys.SPLASH_SCREEN_IMG),
          fit: BoxFit.fill,
        ),
      );
  Widget get gradientColorText => GradientText(
        text: LangKeys.OPENING_STATEMENT.tr(),
        gradient: const LinearGradient(colors: [
          Colors.red,
          Colors.pinkAccent,
          Color(0xff623663),
        ]),
        style: TextStyle(
          fontSize: 34,
          fontFamily: Fonts.medium,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget testData(BuildContext context, LoginCubit loginCubit) => SizedBox(
      height: 80,
      width: context.deviceSize.width,
      child: Row(
        children: [
          Flexible(
            child: CustomMaterialBotton(
                onPressed: () {
                  loginCubit.selectUser(2);
                },
                child: Text('admin user',
                    style: context.textTheme.bodyLarge!
                        .copyWith(color: Colors.white))),
          ),
          hSpace(),
          Flexible(
            child: CustomMaterialBotton(
                onPressed: () {
                  loginCubit.selectUser(18);
                },
                child: Text(
                  'company owner',
                  style: context.textTheme.bodyLarge!
                      .copyWith(color: Colors.white),
                )),
          ),
        ],
      ));
}
