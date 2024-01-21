import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/presentation/settings_page_screen/widgets/radio_button_dropdown_widget.dart';
import 'package:library_ece/presentation/settings_page_screen/widgets/switch_dropdown_widget.dart';
import 'package:library_ece/routes/classes/timer.dart';
import 'package:library_ece/widgets/app_bar/appbar_subtitle.dart';
import 'package:library_ece/widgets/app_bar/custom_app_bar.dart';
import 'package:library_ece/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class SettingsPageScreen extends StatefulWidget {
  SettingsPageScreen({Key? key}) : super(key: key);

  @override
  State<SettingsPageScreen> createState() => _SettingsPageScreenState();
}

class _SettingsPageScreenState extends State<SettingsPageScreen> {
  List<String> notificationsDropDownItemList = [
    "Ανακοινώσεις",
    "Επιστροφή/Ανανέωση Βιβλίου",
  ];

  List<String> homePageDropDownItemList = [
    "Αγαπημένα Βιβλία",
    "Προτείνονται για Εσάς",
    "Νέες Προσθήκες",
    "Δημοφιλή",
    "Λαμβάνετε Ειδοποιήσεις"
  ];

  List<String> libraryPageDropDownItemList = [
    "Προτείνονται για Εσάς",
    "Αγαπημένα",
    "Νέες Προσθήκες",
    "Δημοφιλή",
    "Λαμβάνετε Ειδοποιήσεις"
  ];

  int selectedValue = 0;
  List<String>? libraryPageValues = [];
  List<String>? notificationsValues = [];

  late SharedPreferences prefs;

  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    // Retrieve the saved value from SharedPreferences
    selectedValue = prefs.getInt('HomePageValue') ?? 0;
    print(selectedValue);
    libraryPageValues = prefs.getStringList("libraryPageValues");
    print(libraryPageValues);
    notificationsValues = prefs.getStringList("notificationsValues");
    print(notificationsValues);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initializePreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildWidget(); // Call a separate method to build the widget
        } else {
          return CircularProgressIndicator(); // Or any loading indicator
        }
      },
    );
  }

  Widget buildWidget() {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 40.v),
                child: SingleChildScrollView(
                  child: Column(children: [
                    SwitchDropDownWidget(
                      header: "Ειδοποιήσεις",
                      contents: notificationsDropDownItemList,
                      savedValues: notificationsValues,
                    ),
                    SizedBox(height: 20.v),
                    RadioButtonDropDownWidget(
                      header: "Αρχική Σελίδα",
                      contents: homePageDropDownItemList,
                      firstSelectedValue: selectedValue,
                    ),
                    SizedBox(height: 20.v),
                    SwitchDropDownWidget(
                      header: "Σελίδα Βιβλιοθήκης",
                      contents: libraryPageDropDownItemList,
                      savedValues: libraryPageValues,
                    ),
                    SizedBox(height: 20.v),
                  ]),
                )),
            bottomNavigationBar: _buildLogout(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 30.h,
        leading: GestureDetector(
          onTap: () {
            onTapArrowLeft(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Icon(
              Icons.arrow_back,
              color: appTheme.blueGray100,
              size: 28.adaptSize,
            ),
          ),
        ),
        title: AppbarSubtitle(
            text: "Ρυθμίσεις", margin: EdgeInsets.only(left: 14.h)),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildLogout(BuildContext context) {
    return CustomElevatedButton(
        height: 40.v,
        width: 121.h,
        text: "Logout",
        margin: EdgeInsets.only(left: 120.h, right: 119.h, bottom: 32.v),
        buttonStyle: CustomButtonStyles.fillRed,
        buttonTextStyle: CustomTextStyles.titleMediumOnPrimarySemiBold,
        onPressed: () {
          _showLogoutConfirmationDialog(context);
        });
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Logout",
            textAlign: TextAlign.center,
            style: TextStyle(color: appTheme.blueGray100, fontSize: 20.h),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(color: appTheme.blueGray100, fontSize: 14.h),
            textAlign: TextAlign.center,
          ),
          backgroundColor: appTheme.red900,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: appTheme.blueGray100, fontSize: 14.h),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                onTapLogout(context); // Perform the logout action
              },
              child: Text("Logout",
                  style:
                      TextStyle(color: appTheme.blueGray100, fontSize: 14.h)),
            ),
          ],
        );
      },
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the logoutPageScreen when the action is triggered.
  onTapLogout(BuildContext context) {
    _clearUserData();
    TimerService().stopTimer();
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.loginPageScreen, (route) => false);
  }

  // Method to clear user data in SharedPreferences
  void _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
