import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  static get bodyLargeInterOnPrimary =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get bodyLargeLexend => theme.textTheme.bodyLarge!.lexend.copyWith(
        fontSize: 18.fSize,
      );
  static get bodyLargeOnPrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumBluegray100 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray100,
      );
  static get bodyMediumInterBlack900 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.black900.withOpacity(0.49),
        fontSize: 13.fSize,
      );
  static get bodyMediumInterOnPrimary =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 13.fSize,
      );
  static get bodyMediumOnPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get bodyMediumOnPrimary_1 => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get bodySmall12 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12.fSize,
      );
  static get bodySmallRobotoOnPrimary =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 12.fSize,
      );
  static get bodySmallRobotoOnPrimary11 =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 11.fSize,
      );
  static get bodySmallRobotoSecondaryContainer =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  // Inter text style
  static get interBlack900 => TextStyle(
        color: appTheme.black900,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).inter;
  static get interBlack900Bold => TextStyle(
        color: appTheme.black900,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w700,
      ).inter;
  // Label text style
  static get labelLargeBluegray100 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray100,
      );
  static get labelLargeBluegray100SemiBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray100,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeCrimsonProBluegray100 =>
      theme.textTheme.labelLarge!.crimsonPro.copyWith(
        color: appTheme.blueGray100,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeGreen90001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.green90001,
      );
  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargeRed900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.red900,
      );
  static get labelLargeSemiBold => theme.textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get labelMediumBold => theme.textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get labelMediumRoboto => theme.textTheme.labelMedium!.roboto.copyWith(
        fontWeight: FontWeight.w500,
      );
  // Title text style
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumOnPrimarySemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBluegray100 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray100,
      );
  static get titleSmallBluegray100Bold => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray100,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallGray90001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray90001,
      );
  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 15.fSize,
      );
  static get titleSmallOnPrimary_1 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get titleSmallOnPrimary_2 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get titleSmallOnPrimary_3 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
}

extension on TextStyle {
  TextStyle get crimsonPro {
    return copyWith(
      fontFamily: 'Crimson Pro',
    );
  }

  TextStyle get lexend {
    return copyWith(
      fontFamily: 'Lexend',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
