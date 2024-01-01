import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';

class BootPageScreen extends StatelessWidget {
  const BootPageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 242.v),
          child: Column(
            children: [
              SizedBox(
                height: 131.v,
                width: 136.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 131.v,
                        width: 136.h,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimary.withOpacity(1),
                          borderRadius: BorderRadius.circular(
                            68.h,
                          ),
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgImage1,
                      height: 131.v,
                      width: 136.h,
                      radius: BorderRadius.vertical(
                        bottom: Radius.circular(5.h),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36.v),
              Container(
                decoration: AppDecoration.outlineBlack,
                child: Text(
                  "ECE Library",
                  style: theme.textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
