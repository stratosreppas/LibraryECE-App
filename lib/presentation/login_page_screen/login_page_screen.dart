import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginPageScreen extends StatefulWidget {
  LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText = true;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: theme.colorScheme.primary,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 50.v),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      width: 170.v,
                      height: 170.h,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(1),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(ImageConstant.imgImage1)),
                        border: Border.all(width: 2),
                      )),
                ]),
              ),
              Container(
                  decoration: AppDecoration.outlineBlack,
                  child: Text("ECE Library",
                      style: theme.textTheme.headlineLarge)),
              Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(top: 40.v),
                    child: Column(children: [
                      CustomTextFormField(
                          width: 210.h,
                          controller: emailController,
                          focusNode: emailFocusNode,
                          hintText: "E-mail",
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          suffix: GestureDetector(
                            onTap: () {
                              emailController.clear();
                            },
                            child: Icon(
                              Icons.clear,
                              color: appTheme.blueGray100,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 40.v),
                      ),
                      CustomTextFormField(
                          width: 210.h,
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          hintText: "Password",
                          textInputAction: TextInputAction.done,
                          obscureText: obscureText,
                          textInputType: TextInputType.visiblePassword,
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              obscureText
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye,
                              color: appTheme.blueGray100,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 40.v),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          onTapLogin(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: BorderSide(color: appTheme.blueGray100),
                          fixedSize: Size(101, 40),
                          backgroundColor: appTheme.blueGray100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_forward,
                                color: theme.colorScheme.primary),
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    ]),
                  )),
              Container(
                padding: EdgeInsets.only(top: 20.v),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: CustomTextStyles.bodyLargeBlack900
                        .copyWith(fontSize: 14.0),
                  ),
                  GestureDetector(
                      onTap: () {
                        onTapTxtSignUp(context);
                      },
                      child: Container(
                          width: 62.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 8.v),
                          decoration: AppDecoration.fillPrimary.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder10),
                          child: Text("Sign up",
                              style: CustomTextStyles.bodyLargeOnPrimary
                                  .copyWith(fontSize: 15.0))))
                ],
              )
            ]),
          )),
    ));
  }

  /// Navigates to the homePageContainerScreen when the action is triggered.
  onTapLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homePage);
  }

  /// Navigates to the signupPageScreen when the action is triggered.
  onTapTxtSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupPageScreen);
  }
}
