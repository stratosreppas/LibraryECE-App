import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_outlined_button.dart';
import 'package:stratos_s_application3/widgets/custom_text_form_field.dart';
import 'package:stratos_s_application3/widgets/custom_drop_down.dart';

class SignupPageScreen extends StatelessWidget {
  SignupPageScreen({Key? key}) : super(key: key);

  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController eyeFieldController = TextEditingController();
  TextEditingController textField1Controller = TextEditingController();
  TextEditingController textField2Controller = TextEditingController();
  TextEditingController textField3Controller = TextEditingController();
  TextEditingController textField4Controller = TextEditingController();



  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 50.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 2.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgAccountCircle,
                    height: 166.adaptSize,
                    width: 166.adaptSize,
                  ),
                  SizedBox(height: 16.v),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                    decoration: AppDecoration.fillPrimary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.v),
                        _buildEmailField(context),
                        SizedBox(height: 20.v),
                        _buildPasswordField(context),
                        SizedBox(height: 20.v),
                        _buildEyeField(context),
                        SizedBox(height: 20.v),
                        _buildTextField1(context),
                        SizedBox(height: 20.v),
                        _buildTextField2(context),
                        SizedBox(height: 20.v),
                        _buildTextField3(context),
                        SizedBox(height: 20.v),
                        _buildTextField4(context),
                        SizedBox(height: 20.v),  // Add some space after the last text field
                        _buildPropertyDropdown(context),
                        SizedBox(height: 76.v),
                        _buildSignUpButton(context),  // Add the Sign Up button here
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


/// Section Widget
  Widget _buildEmailField(BuildContext context) {
    return CustomTextFormField(
        controller: emailFieldController,
        hintText: "Email",
        textInputType: TextInputType.emailAddress);
  }

  /// Section Widget
  Widget _buildPasswordField(BuildContext context) {
    return CustomTextFormField(
        controller: passwordFieldController,
        hintText: "Password",
        textInputType: TextInputType.visiblePassword,
        suffix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 16.v, 11.h, 16.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgEye,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        suffixConstraints: BoxConstraints(maxHeight: 56.v),
        obscureText: true,
        contentPadding: EdgeInsets.only(left: 16.h, top: 18.v, bottom: 18.v));
  }

  /// Section Widget
  Widget _buildEyeField(BuildContext context) {
    return CustomTextFormField(
        controller: eyeFieldController,
        hintText: "Επαναλάβετε ",
        textInputType: TextInputType.visiblePassword,
        suffix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 16.v, 11.h, 16.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgEye,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        suffixConstraints: BoxConstraints(maxHeight: 56.v),
        obscureText: true,
        contentPadding: EdgeInsets.only(left: 16.h, top: 18.v, bottom: 18.v));
  }

  /// Section Widget
  Widget _buildTextField1(BuildContext context) {
    return CustomTextFormField(
        controller: textField1Controller, hintText: "Όνομα");
  }

  /// Section Widget
  Widget _buildTextField2(BuildContext context) {
    return CustomTextFormField(
        controller: textField2Controller, hintText: "Επώνυμο");
  }

  /// Section Widget
  Widget _buildTextField3(BuildContext context) {
    return CustomTextFormField(
        controller: textField3Controller,
        hintText: "Κινητό Τηλέφωνο",
        textInputAction: TextInputAction.done);
  }
/// Section Widget
  Widget _buildTextField4(BuildContext context) {
    return CustomTextFormField(
        controller: textField4Controller,
        hintText: "Αριθμός Μητρώου",
        textInputAction: TextInputAction.done);
  }

  /// Section Widget
  Widget _buildPropertyDropdown(BuildContext context) {
    return CustomDropDown();
  }

  /// Section Widget
  Widget _buildSignUpButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        // Add your sign-up logic here
        onTapStateLayer(context);
      },
      color: Colors.white, // Set the background color to white
      child: Text(
        'Sign Up',
        style: TextStyle(
          color: theme.colorScheme.primary, // Set the text color to the primary color
        ),
      ),
    );
  }

  /// Navigates to the homePageContainerScreen when the action is triggered.
  onTapStateLayer(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homePageContainerScreen);
  }
}