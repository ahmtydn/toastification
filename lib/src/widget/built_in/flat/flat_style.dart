import 'package:flutter/material.dart';
import 'package:toastification/src/helper/toast_helper.dart';
import 'package:toastification/toastification.dart';

class FlatStyle extends BuiltInStyle {
  const FlatStyle(super.type);

  @override
  MaterialColor primaryColor(BuildContext context) {
    late final Color color;
    switch (type) {
      case ToastificationType.info:
        color = infoColor;
        break;
      case ToastificationType.warning:
        color = warningColor;
        break;
      case ToastificationType.success:
        color = successColor;
        break;
      case ToastificationType.error:
        color = errorColor;
        break;
      default:
        throw ArgumentError('Unknown ToastificationType: $type');
    }

    return ToastHelper.createMaterialColor(color);
  }

  @override
  MaterialColor onPrimaryColor(BuildContext context) {
    return ToastHelper.createMaterialColor(Colors.white);
  }

  @override
  Color backgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? const Color(0xffFfffff)
        : const Color(0xff2B2B2B);
  }

  @override
  Color foregroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  @override
  Color iconColor(BuildContext context) {
    return primaryColor(context);
  }

  @override
  IconData closeIcon(BuildContext context) {
    return Icons.close;
  }

  @override
  Color closeIconColor(BuildContext context) {
    return foregroundColor(context).withOpacity(.3);
  }

  @override
  BorderSide borderSide(BuildContext context) {
    return const BorderSide(
      color: Color(0xffEBEBEB),
      width: 1.5,
    );
  }

  @override
  BorderRadiusGeometry borderRadius(BuildContext context) {
    return const BorderRadius.all(Radius.circular(12));
  }

  @override
  ProgressIndicatorThemeData progressIndicatorTheme(BuildContext context) {
    return ProgressIndicatorThemeData(
      color: foregroundColor(context).withOpacity(.15),
      linearMinHeight: super.progressIndicatorStrokeWidth(context),
      linearTrackColor: foregroundColor(context).withOpacity(.05),
      refreshBackgroundColor: foregroundColor(context).withOpacity(.05),
    );
  }
}
