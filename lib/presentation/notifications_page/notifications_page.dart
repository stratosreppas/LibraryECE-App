import '../notifications_page/widgets/notificationlist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_title.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_trailing_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.only(
            left: 5.h,
            top: 19.v,
            right: 5.h,
          ),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 14.v,
              );
            },
            itemCount: 6,
            itemBuilder: (context, index) {
              return NotificationlistItemWidget();
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: SizedBox(
        height: 30.v,
        width: 199.h,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            AppbarTitle(
              text: "ECE Library",
              margin: EdgeInsets.only(
                top: 3.v,
                bottom: 12.v,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(
                  left: 9.h,
                  right: 160.h,
                ),
                decoration: AppDecoration.fillOnPrimary.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder15,
                ),
                child: AppbarImage(
                  imagePath: ImageConstant.imgImage1,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMegaphone,
          margin: EdgeInsets.symmetric(
            horizontal: 5.h,
            vertical: 7.v,
          ),
        ),
      ],
      styleType: Style.bgFill,
    );
  }
}
