import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teste_projeto_47/utils/constants.dart';

class Notifications {
  static warning({
    String? title,
    String? message,
    Duration? duration,
  }) {
    notificationBase(
      key: 'SnackbarWarning',
      backgroundColor: Colors.orange,
      title: title,
      message: message,
      duration: duration,
    );
  }

  static success({
    String? title,
    String? message,
    Duration? duration,
  }) {
    notificationBase(
      key: 'SnackbarSuccess',
      backgroundColor: Colors.green,
      title: title,
      message: message,
      duration: duration,
    );
  }

  static error({
    String? title,
    String? message,
    Duration? duration,
  }) {
    notificationBase(
      key: 'SnackbarError',
      backgroundColor: Colors.red,
      title: title,
      message: message,
      duration: duration,
    );
  }

  static notificationBase({
    String? key,
    Color? backgroundColor,
    String? title,
    String? message,
    Duration? duration,
  }) {
    showStyledToast(
      duration: duration ?? const Duration(seconds: 10),
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.all(8.sp),
      contentPadding: const EdgeInsets.all(0),
      alignment: const Alignment(0, -1.0),
      child: Dismissible(
        key: ValueKey<String>('$key'),
        child: Container(
          width: 0.9.sw,
          padding: EdgeInsets.all(7.sp),
          margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(7.sp),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 25.sp,
                color: Constants.color1,
              ),
              SizedBox(
                width: 5.sp,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title",
                      style: TextStyle(
                        color: Constants.color1,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$message",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Constants.color1,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ToastManager.dismissAll();
                },
                iconSize: 25.sp,
                icon: const Icon(
                  Icons.close,
                  color: Constants.color1,
                ),
              ),
            ],
          ),
        ),
      ),
      context: ToastProvider.context,
      animationBuilder: (context, animation, child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
    );
  }
}
