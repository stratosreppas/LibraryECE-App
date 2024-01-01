import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:stratos_s_application3/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class FaqsPageScreen extends StatelessWidget {
  FaqsPageScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(children: [
                      Container(
                          height: 28.v,
                          width: double.maxFinite,
                          decoration:
                              BoxDecoration(color: appTheme.blueGray100)),
                      SizedBox(height: 16.v),
                      _buildDropContent1(context),
                      SizedBox(height: 25.v),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.h),
                          child: CustomTextFormField(
                              controller: emailController,
                              hintText:
                                  "Μπορώ να τυπώσω από USB stick ή από το προσωπικό μου e-mail / cloud;",
                              hintStyle: CustomTextStyles.titleSmallBluegray100,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.h, vertical: 19.v),
                              borderDecoration:
                                  TextFormFieldStyleHelper.fillPrimary,
                              filled: true,
                              fillColor: theme.colorScheme.primary)),
                      SizedBox(height: 25.v),
                      _buildDropContent2(context),
                      SizedBox(height: 25.v),
                      _buildDropContent3(context),
                      SizedBox(height: 25.v),
                      _buildDropContent4(context),
                      SizedBox(height: 25.v),
                      _buildDropContent5(context),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 30.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 6.h, top: 9.v, bottom: 9.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title:
            AppbarSubtitle(text: "FAQs", margin: EdgeInsets.only(left: 14.h)),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildDropContent1(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                      width: 244.h,
                      margin: EdgeInsets.only(bottom: 8.v),
                      child: Text(
                          "Ποιές μέρες η βιβλιοθήκη είναι κλειστή, πέραν του μόνιμου ωραρίου; Πότε είναι ανοικτή η βιβλιοθήκη;",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.titleSmallBluegray100
                              .copyWith(height: 1.43)))),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(left: 13.h, top: 4.v, bottom: 14.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Section Widget
  Widget _buildDropContent2(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 203.h,
                  margin: EdgeInsets.only(bottom: 8.v),
                  child: Text(
                      "Γιατί να τιμωρηθώ επειδή καθυστέρησα να επιστρέψω το βιβλίο που δανείστηκα;",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallBluegray100
                          .copyWith(height: 1.43))),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(left: 54.h, top: 4.v, bottom: 14.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Section Widget
  Widget _buildDropContent3(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 213.h,
                  margin: EdgeInsets.only(top: 5.v, bottom: 13.v),
                  child: Text(
                      "Μπορώ να κάνω αίτηση για να εργαστώ κι εγώ στη βιβλιοθήκη;",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallBluegray100
                          .copyWith(height: 1.43))),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(left: 44.h, bottom: 10.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Section Widget
  Widget _buildDropContent4(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                      width: 240.h,
                      margin: EdgeInsets.only(top: 5.v, bottom: 13.v),
                      child: Text(
                          "Γιατί δεν μπορώ να πάρω την τσάντα μου μαζί μου στο αναγνωστήριο;",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.titleSmallBluegray100
                              .copyWith(height: 1.43)))),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(left: 17.h, bottom: 10.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Section Widget
  Widget _buildDropContent5(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                      width: 228.h,
                      margin: EdgeInsets.only(top: 5.v, bottom: 13.v),
                      child: Text(
                          "Γιατί δεν μπορώ να πάρω τον καφέ μαζί μου στο αναγνωστήριο;",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.titleSmallBluegray100
                              .copyWith(height: 1.43)))),
              Container(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(left: 29.h, bottom: 10.v),
                  decoration: BoxDecoration(
                      color: appTheme.blueGray100,
                      borderRadius: BorderRadius.circular(25.h)))
            ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
