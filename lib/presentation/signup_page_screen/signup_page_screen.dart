import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignupPageScreen extends StatefulWidget {
  SignupPageScreen({Key? key}) : super(key: key);

  @override
  State<SignupPageScreen> createState() => _SignupPageScreenState();
}

class _SignupPageScreenState extends State<SignupPageScreen> {
  late final TextEditingController emailFieldController;
  late final TextEditingController passwordFieldController;
  late final TextEditingController repeatPasswordFieldController;
  late final TextEditingController textFirstNameController;
  late final TextEditingController textLastNameController;
  late final TextEditingController textPhoneNumberController;
  late final TextEditingController textRegistrationIDController;

  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode repeatPasswordFocusNode;
  late final FocusNode firstNameFocusNode;
  late final FocusNode lastNameFocusNode;
  late final FocusNode phoneNumberFocusNode;
  late final FocusNode registrationIDFocusNode;

  String? selectedRole;
  List<String> list = <String>[
    'Προπτυχιακός/ή',
    'Μεταπτυχιακός/ή',
    "Υποψήφιος/α Διδάκτωρ",
    'Καθηγητής/τρια'
  ];
  String? dropdownValue;

  final TextEditingController roleController = TextEditingController();

  bool obscureText = true;
  bool obscureTextRepeat = true;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    emailFieldController = TextEditingController();
    passwordFieldController = TextEditingController();
    repeatPasswordFieldController = TextEditingController();
    textFirstNameController = TextEditingController();
    textLastNameController = TextEditingController();
    textPhoneNumberController = TextEditingController();
    textRegistrationIDController = TextEditingController();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    repeatPasswordFocusNode = FocusNode();
    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    registrationIDFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailFieldController.dispose();
    passwordFieldController.dispose();
    textFirstNameController.dispose();
    textLastNameController.dispose();
    textPhoneNumberController.dispose();
    textRegistrationIDController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    registrationIDFocusNode.dispose();

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
          body: Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 20.v),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      width: 140.v,
                      height: 140.h,
                      decoration: BoxDecoration(
                        color: appTheme.blueGray100,
                        shape: BoxShape.circle,
                      )),
                  Icon(
                    Icons.account_circle_outlined,
                    size: 143,
                  ),
                ]),
              ),
              Container(
                  decoration: AppDecoration.outlineBlack,
                  padding: EdgeInsets.only(bottom: 20.v),
                  child: Text("Create Account",
                      style: theme.textTheme.headlineLarge)),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Container(
                          child: Column(children: [
                        CustomTextFormField(
                            width: 210.h,
                            controller: emailFieldController,
                            focusNode: emailFocusNode,
                            hintText: "E-mail",
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            suffix: GestureDetector(
                              onTap: () {
                                emailFieldController.clear();
                              },
                              child: Icon(
                                Icons.clear,
                                color: appTheme.blueGray100,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20.v),
                        ),
                        CustomTextFormField(
                            width: 210.h,
                            controller: passwordFieldController,
                            focusNode: passwordFocusNode,
                            hintText: "Password",
                            textInputAction: TextInputAction.next,
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
                          padding: EdgeInsets.only(top: 20.v),
                        ),
                        CustomTextFormField(
                            width: 210.h,
                            controller: repeatPasswordFieldController,
                            focusNode: repeatPasswordFocusNode,
                            hintText: "Repeat Password",
                            textInputAction: TextInputAction.next,
                            obscureText: obscureTextRepeat,
                            textInputType: TextInputType.visiblePassword,
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureTextRepeat = !obscureTextRepeat;
                                });
                              },
                              child: Icon(
                                obscureTextRepeat
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                color: appTheme.blueGray100,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20.v),
                        ),
                        CustomTextFormField(
                            width: 210.h,
                            controller: textFirstNameController,
                            focusNode: firstNameFocusNode,
                            hintText: "First Name",
                            textInputType: TextInputType.name,
                            suffix: GestureDetector(
                              onTap: () {
                                textFirstNameController.clear();
                              },
                              child: Icon(
                                Icons.clear,
                                color: appTheme.blueGray100,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20.v),
                        ),
                        CustomTextFormField(
                            width: 210.h,
                            controller: textLastNameController,
                            focusNode: lastNameFocusNode,
                            hintText: "Last Name",
                            textInputType: TextInputType.name,
                            suffix: GestureDetector(
                              onTap: () {
                                textLastNameController.clear();
                              },
                              child: Icon(
                                Icons.clear,
                                color: appTheme.blueGray100,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20.v),
                        ),
                        CustomTextFormField(
                            width: 210.h,
                            controller: textPhoneNumberController,
                            focusNode: phoneNumberFocusNode,
                            hintText: "Phone Number",
                            textInputType: TextInputType.phone,
                            suffix: GestureDetector(
                              onTap: () {
                                textPhoneNumberController.clear();
                              },
                              child: Icon(
                                Icons.clear,
                                color: appTheme.blueGray100,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20.v),
                        ),
                        CustomTextFormField(
                            width: 210.h,
                            controller: textRegistrationIDController,
                            focusNode: registrationIDFocusNode,
                            hintText: "Registration ID",
                            textInputType: TextInputType.text,
                            suffix: GestureDetector(
                              onTap: () {
                                textRegistrationIDController.clear();
                              },
                              child: Icon(
                                Icons.clear,
                                color: appTheme.blueGray100,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20.v),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 74.h, right: 74.h),
                          child: Container(
                            padding: EdgeInsets.only(left: 25.h, right: 25.h),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: appTheme.blueGray100,
                                ),
                                borderRadius: BorderRadius.circular(4.h)),
                            child: DropdownButton(
                                hint: Center(
                                  child: Text(
                                    "Select Role",
                                    style: TextStyle(
                                      color: appTheme.blueGray100,
                                    ),
                                  ),
                                ),
                                dropdownColor: theme.colorScheme.primary,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: appTheme.blueGray100,
                                ),
                                iconSize: 36.h,
                                style: TextStyle(
                                    color: appTheme.blueGray100,
                                    fontSize: 14.h),
                                isExpanded: true,
                                underline: SizedBox(),
                                value: selectedRole,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedRole = newValue;
                                  });
                                },
                                items: list.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Center(child: Text(valueItem)),
                                  );
                                }).toList()),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20.v),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            onTapStateLayer(context);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.h),
                            ),
                            side: BorderSide(color: appTheme.blueGray100),
                            fixedSize: Size(101.h, 40.v),
                            backgroundColor: appTheme.blueGray100,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_forward,
                                  color: theme.colorScheme.primary),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 14.0.h, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 20.v),
                        ),
                      ]))),
                ),
              ),
            ],
          )),
    ));
  }

  onTapStateLayer(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginPageScreen);
  }
}
