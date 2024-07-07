import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:toastification/toastification.dart';

/// default style for info toastification
const infoColor = Color(0xFF47AFFF);

/// default color for success toastification
const successColor = Color(0xFF32BC32);

/// default color for warning toastification
const warningColor = Color(0xFFFFB600);

/// default color for error toastification
const errorColor = Color(0xFFFF3A30);

const lowModeShadow = [
  BoxShadow(
    color: Color(0x07000000),
    blurRadius: 16,
    offset: Offset(0, 16),
    spreadRadius: 0,
  )
];

const highModeShadow = [
  BoxShadow(
    color: Color(0x14000000),
    blurRadius: 30,
    offset: Offset(0, 20),
    spreadRadius: 0,
  )
];

/// Base abstract class for built-in styles
abstract class BuiltInStyle {
  const BuiltInStyle(this.type);

  factory BuiltInStyle.fromToastificationStyle(
    ToastificationStyle style,
    ToastificationType type,
  ) {
    switch (style) {
      case ToastificationStyle.minimal:
        return MinimalStyle(type);
      case ToastificationStyle.fillColored:
        return FilledStyle(type);
      case ToastificationStyle.flatColored:
        return FlatColoredStyle(type);
      case ToastificationStyle.flat:
        return FlatStyle(type);
      case ToastificationStyle.simple:
        return SimpleStyle(type);
      default:
        throw ArgumentError('Unknown ToastificationStyle: $style');
    }
  }

  final ToastificationType type;

  EdgeInsetsGeometry padding(BuildContext context) =>
      const EdgeInsetsDirectional.fromSTEB(20, 16, 12, 16);

  MaterialColor primaryColor(BuildContext context);
  MaterialColor onPrimaryColor(BuildContext context);
  Color backgroundColor(BuildContext context);
  Color foregroundColor(BuildContext context);

  IconData icon(BuildContext context) {
    switch (type) {
      case ToastificationType.success:
        return Iconsax.tick_circle_copy;
      case ToastificationType.info:
        return Iconsax.info_circle_copy;
      case ToastificationType.warning:
        return Iconsax.danger_copy;
      case ToastificationType.error:
        return Iconsax.close_circle_copy;
      default:
        throw ArgumentError('Unknown ToastificationType: $type');
    }
  }

  Color iconColor(BuildContext context);

  IconData closeIcon(BuildContext context);
  Color closeIconColor(BuildContext context);

  BorderSide borderSide(BuildContext context);

  BorderRadiusGeometry borderRadius(BuildContext context);

  TextStyle? titleTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall?.copyWith(
            color: foregroundColor(context),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.2,
          );

  TextStyle? descriptionTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall?.copyWith(
            color: foregroundColor(context).withOpacity(.7),
            fontSize: 14,
            fontWeight: FontWeight.w300,
            height: 1.2,
          );

  double elevation(BuildContext context) => 0.0;
  List<BoxShadow> boxShadow(BuildContext context) => const [];

  double progressIndicatorStrokeWidth(BuildContext context) => 2.0;

  ProgressIndicatorThemeData progressIndicatorTheme(BuildContext context);
}
