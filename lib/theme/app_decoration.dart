import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
      );
  static BoxDecoration get fillLightGreen => BoxDecoration(
        color: appTheme.lightGreen900,
      );
  static BoxDecoration get fillLime => BoxDecoration(
        color: appTheme.lime800,
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get fillPrimary1 => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.92),
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red90001.withOpacity(0.5),
      );
  static BoxDecoration get fillRed900 => BoxDecoration(
        color: appTheme.red900,
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration();
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        color: appTheme.purple50,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.15),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              2,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.deepOrange50,
        border: Border.all(
          color: appTheme.gray600,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGrayE => BoxDecoration(
        border: Border.all(
          color: appTheme.gray9001e,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineLightGreen => BoxDecoration(
        color: appTheme.blueGray100,
        border: Border(
          left: BorderSide(
            color: appTheme.lightGreen900,
            width: 5.h,
          ),
        ),
      );
  static BoxDecoration get outlineLime => BoxDecoration(
        color: appTheme.blueGray100,
        border: Border(
          left: BorderSide(
            color: appTheme.lime800,
            width: 5.h,
          ),
        ),
      );
  static BoxDecoration get outlineOnPrimaryContainer => BoxDecoration(
        color: appTheme.blueGray100,
        border: Border(
          left: BorderSide(
            color: theme.colorScheme.onPrimaryContainer,
            width: 5.h,
          ),
        ),
      );

  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2.h,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder15 => BorderRadius.circular(
        15.h,
      );
  static BorderRadius get circleBorder30 => BorderRadius.circular(
        30.h,
      );
  static BorderRadius get circleBorder7 => BorderRadius.circular(
        7.h,
      );

  // Custom borders
  static BorderRadius get customBorderBL5 => BorderRadius.vertical(
        bottom: Radius.circular(5.h),
      );
  static BorderRadius get customBorderBR5 => BorderRadius.only(
        bottomRight: Radius.circular(5.h),
      );
  static BorderRadius get customBorderTL10 => BorderRadius.vertical(
        top: Radius.circular(10.h),
      );
  static BorderRadius get customBorderTL5 => BorderRadius.vertical(
        top: Radius.circular(5.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder18 => BorderRadius.circular(
        18.h,
      );
  static BorderRadius get roundedBorder3 => BorderRadius.circular(
        3.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
