import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                          width: 260.h,
                          controller: emailController,
                          focusNode: emailFocusNode,
                          hintText: "E-mail",
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            return null;
                          },
                          textStyle: TextStyle(fontSize: 16.h),
                          cursorColor: appTheme.blueGray100,
                          showCursor: true,
                          suffix: GestureDetector(
                            onTap: () {
                              emailController.clear();
                            },
                            child: Icon(
                              Icons.clear,
                              color: appTheme.blueGray100,
                              size: 24.h,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 40.v),
                      ),
                      CustomTextFormField(
                          width: 260.h,
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          hintText: "Password",
                          textInputAction: TextInputAction.done,
                          obscureText: obscureText,
                          textInputType: TextInputType.visiblePassword,
                          cursorColor: appTheme.blueGray100,
                          showCursor: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          textStyle: TextStyle(fontSize: 16.h),
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
                              size: 24.h,
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
                            borderRadius: BorderRadius.circular(20.h),
                          ),
                          side: BorderSide(color: appTheme.blueGray100),
                          fixedSize: Size(120.v, 45.h),
                          backgroundColor: appTheme.blueGray100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: theme.colorScheme.primary,
                              size: 22.h,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16.0.h, color: Colors.black),
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
                        .copyWith(fontSize: 14.0.h),
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
                                  .copyWith(fontSize: 15.0.h))))
                ],
              )
            ]),
          )),
    ));
  }

  /// Navigates to the homePageContainerScreen when the action is triggered.
  onTapLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Process data.
      final response = await http.post(
        Uri.parse('http://10.3.24.47:4000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mail': emailController.text,
          'password': passwordController.text,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        // Successful login
        String successMessage = responseData['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            successMessage,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromARGB(255, 16, 124, 6),
          elevation: 8,
          padding: EdgeInsets.all(8.h),
          dismissDirection: DismissDirection.down,
        ));
        Navigator.pushNamed(context, AppRoutes.homePage);
      } else {
        // Handle unsuccessful login (show an error message, etc.)
        String errorMessage = responseData['message'] ?? 'Unknown error';
        print("Error: $errorMessage");
        // Show a snackbar or display the error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromARGB(255, 180, 14, 3),
            elevation: 8,
            padding: EdgeInsets.all(8.h),
            dismissDirection: DismissDirection.down,
          ),
        );
      }
    }
  }

  /// Navigates to the signupPageScreen when the action is triggered.
  onTapTxtSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupPageScreen);
  }
}
