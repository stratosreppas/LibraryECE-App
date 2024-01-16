import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPageScreen extends StatefulWidget {
  SignupPageScreen({Key? key}) : super(key: key);

  @override
  State<SignupPageScreen> createState() => _SignupPageScreenState();
}

class _SignupPageScreenState extends State<SignupPageScreen> {
  late final TextEditingController emailFieldController;
  late final TextEditingController passwordFieldController;
  late final TextEditingController repeatPasswordFieldController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController registrationIDController;

  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode repeatPasswordFocusNode;
  late final FocusNode firstNameFocusNode;
  late final FocusNode lastNameFocusNode;
  late final FocusNode phoneNumberFocusNode;
  late final FocusNode registrationIDFocusNode;

  String? selectedRole;
  List<String> roleList = <String>[
    'Προπτυχιακός/ή',
    'Μεταπτυχιακός/ή',
    "Υποψήφιος/α Διδάκτωρ",
    'Καθηγητής/τρια',
    "Κατατακτήριος/α",
    "Φοιτητής/τρια \nάλλης σχολής"
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
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    registrationIDController = TextEditingController();

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
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    registrationIDController.dispose();

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
                      width: 140.h,
                      height: 140.v,
                      decoration: BoxDecoration(
                        color: appTheme.blueGray100,
                        shape: BoxShape.circle,
                      )),
                  Icon(
                    Icons.account_circle_outlined,
                    size: 162.h,
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
                            width: 260.h,
                            controller: emailFieldController,
                            focusNode: emailFocusNode,
                            hintText: "E-mail",
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your e-mail';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid e-mail address';
                              }
                              return null;
                            },
                            textStyle: TextStyle(fontSize: 16.h),
                            cursorColor: appTheme.blueGray100,
                            showCursor: true,
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
                            width: 260.h,
                            controller: passwordFieldController,
                            focusNode: passwordFocusNode,
                            hintText: "Password",
                            textInputAction: TextInputAction.next,
                            obscureText: obscureText,
                            textInputType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                            textStyle: TextStyle(fontSize: 16.h),
                            cursorColor: appTheme.blueGray100,
                            showCursor: true,
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
                            width: 260.h,
                            controller: repeatPasswordFieldController,
                            focusNode: repeatPasswordFocusNode,
                            hintText: "Repeat Password",
                            textInputAction: TextInputAction.next,
                            obscureText: obscureTextRepeat,
                            textInputType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please repeat your password';
                              } else if (value !=
                                  passwordFieldController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            textStyle: TextStyle(fontSize: 16.h),
                            cursorColor: appTheme.blueGray100,
                            showCursor: true,
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
                            width: 260.h,
                            controller: firstNameController,
                            focusNode: firstNameFocusNode,
                            hintText: "First Name",
                            textInputType: TextInputType.name,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            textStyle: TextStyle(fontSize: 16.h),
                            cursorColor: appTheme.blueGray100,
                            showCursor: true,
                            suffix: GestureDetector(
                              onTap: () {
                                firstNameController.clear();
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
                            width: 260.h,
                            controller: lastNameController,
                            focusNode: lastNameFocusNode,
                            hintText: "Last Name",
                            textInputType: TextInputType.name,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            textStyle: TextStyle(fontSize: 16.h),
                            cursorColor: appTheme.blueGray100,
                            showCursor: true,
                            suffix: GestureDetector(
                              onTap: () {
                                lastNameController.clear();
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
                            width: 260.h,
                            controller: phoneNumberController,
                            focusNode: phoneNumberFocusNode,
                            hintText: "Phone Number",
                            textInputType: TextInputType.phone,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            textStyle: TextStyle(fontSize: 16.h),
                            cursorColor: appTheme.blueGray100,
                            showCursor: true,
                            suffix: GestureDetector(
                              onTap: () {
                                phoneNumberController.clear();
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
                            width: 260.h,
                            controller: registrationIDController,
                            focusNode: registrationIDFocusNode,
                            hintText: "Registration ID",
                            textInputType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your registration id';
                              } else if (!RegExp(r'\d{5}').hasMatch(value)) {
                                return 'Please enter a valid registration id';
                              }
                              return null;
                            },
                            textStyle: TextStyle(fontSize: 16.h),
                            cursorColor: appTheme.blueGray100,
                            showCursor: true,
                            suffix: GestureDetector(
                              onTap: () {
                                registrationIDController.clear();
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
                                items: roleList.map((valueItem) {
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

  onTapStateLayer(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select a role',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.h),
            ),
            backgroundColor: Color.fromARGB(255, 180, 14, 3),
          ),
        );
      } else {
        final response = await http.post(
          Uri.parse('http://10.3.24.48:4000/signup'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'mail': emailFieldController.text,
            'password': passwordFieldController.text,
            'first_name': firstNameController.text,
            'last_name': lastNameController.text,
            'phone': phoneNumberController.text,
            'registration_id': registrationIDController.text,
            'role': selectedRole ?? ''
          }),
        );
        final responseData = json.decode(response.body);

        if (response.statusCode == 200 && responseData['status'] == 'success') {
          // Successful signup
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
          Navigator.pushReplacementNamed(context, AppRoutes.loginPageScreen);
        }
      }
    }
  }
}
