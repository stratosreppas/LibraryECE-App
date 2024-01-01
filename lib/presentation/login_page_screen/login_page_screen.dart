import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';
import 'package:stratos_s_application3/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginPageScreen extends StatelessWidget {
  LoginPageScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.primary,
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 81.v),
                    child: Column(children: [
                      SizedBox(
                          height: 131.v,
                          width: 136.h,
                          child: Stack(alignment: Alignment.center, children: [
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    height: 131.v,
                                    width: 136.h,
                                    decoration: BoxDecoration(
                                        color: theme.colorScheme.onPrimary
                                            .withOpacity(1),
                                        borderRadius:
                                            BorderRadius.circular(68.h)))),
                            CustomImageView(
                                imagePath: ImageConstant.imgImage1,
                                height: 131.v,
                                width: 136.h,
                                radius: BorderRadius.vertical(
                                    bottom: Radius.circular(5.h)),
                                alignment: Alignment.center)
                          ])),
                      SizedBox(height: 36.v),
                      Container(
                          decoration: AppDecoration.outlineBlack,
                          child: Text("ECE Library",
                              style: theme.textTheme.headlineLarge)),
                      SizedBox(height: 38.v),
                      CustomTextFormField(
                          width: 210.h,
                          controller: emailController,
                          hintText: "Email",
                          textInputType: TextInputType.emailAddress),
                      SizedBox(height: 35.v),
                      CustomTextFormField(
                          width: 210.h,
                          controller: passwordController,
                          hintText: "Password",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          suffix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(30.h, 16.v, 21.h, 16.v),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgEye,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize)),
                          suffixConstraints: BoxConstraints(maxHeight: 56.v),
                          obscureText: true,
                          contentPadding: EdgeInsets.only(
                              left: 16.h, top: 18.v, bottom: 18.v)),
                      SizedBox(height: 22.v),
                      CustomOutlinedButton(
                          height: 40.v,
                          width: 101.h,
                          text: "Login",
                          leftIcon: Container(
                              margin: EdgeInsets.only(right: 8.h),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgArrowright,
                                  height: 18.adaptSize,
                                  width: 18.adaptSize)),
                          buttonStyle: CustomButtonStyles.outlineGrayE,
                          buttonTextStyle: CustomTextStyles.titleSmallGray90001,
                          onPressed: () {
                            onTapLogin(context);
                          }),
                      SizedBox(height: 43.v),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                              height: 39.v,
                              width: 225.h,
                              child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Don’t have an account? ",
                                            style: CustomTextStyles
                                                .bodyLargeBlack900)),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                            onTap: () {
                                              onTapTxtSignUp(context);
                                            },
                                            child: Container(
                                                width: 62.h,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.h,
                                                    vertical: 8.v),
                                                decoration: AppDecoration
                                                    .fillPrimary
                                                    .copyWith(
                                                        borderRadius:
                                                            BorderRadiusStyle
                                                                .roundedBorder10),
                                                child: Text("Sign up",
                                                    style: CustomTextStyles
                                                        .bodyLargeOnPrimary))))
                                  ]))),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Navigates to the homePageContainerScreen when the action is triggered.
  onTapLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homePageContainerScreen);
  }

  /// Navigates to the signupPageScreen when the action is triggered.
  onTapTxtSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupPageScreen);
  }
}
