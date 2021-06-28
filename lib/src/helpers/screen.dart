import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Size? screenSize;
const double defaultScreenWidth = 750;
const double defaultScreenHeight = 1334;
const double screenWidth = defaultScreenWidth;
const double screenHeight = defaultScreenHeight;

class ConstScreen {
  /*Padding & Margin Constants*/

  static double sizeExtraSmall = 5.0;
  static double sizeDefault = 8.0;
  static double sizeSmall = 10.0;
  static double sizeMedium = 15.0;
  static double sizeLarge = 20.0;
  static double sizeXL = 35.0;
  static double sizeXXL = 40.0;
  static double sizeXXXL = 50.0;

  /*Screen Size dependent Constants*/
  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;
  static double screenWidthSixth = screenWidth / 6;
  static double screenWidthTenth = screenWidth / 10;

  /*Image Dimensions*/

  static double defaultIconSize = 80.0;
  static double defaultImageHeight = 120.0;
  static double snackBarHeight = 50.0;
  static double texIconSize = 30.0;

  /*Default Height&Width*/
  static double defaultIndicatorHeight = 5.0;
  static double defaultIndicatorWidth = screenWidthFourth;

  /*EdgeInsets*/
  static EdgeInsets spacingAllDefault = EdgeInsets.all(sizeDefault);
  static EdgeInsets spacingAllSmall = EdgeInsets.all(sizeSmall);

  static double setSizeHeight(double size) {
    return ScreenUtil().setHeight(size).toDouble();
  }

  static double setSizeWidth(double size) {
    return ScreenUtil().setWidth(size).toDouble();
  }

  static void setScreen(context) {
    ScreenUtil.init(context,
        width: defaultScreenWidth,
        height: defaultScreenHeight,
        allowFontScaling: true);

    FontSize.setScreenAwareFontSize();

    /*Padding & Margin Constants*/

    sizeExtraSmall = ScreenUtil().setWidth(5.0).toDouble();
    sizeDefault = ScreenUtil().setWidth(8.0).toDouble();
    sizeSmall = ScreenUtil().setWidth(10.0).toDouble();
    sizeMedium = ScreenUtil().setWidth(15.0).toDouble();
    sizeLarge = ScreenUtil().setWidth(20.0).toDouble();
    sizeXL = ScreenUtil().setWidth(35.0).toDouble();
    sizeXXL = ScreenUtil().setWidth(40.0).toDouble();
    sizeXXXL = ScreenUtil().setWidth(50.0).toDouble();

    /*EdgeInsets*/

    spacingAllDefault = EdgeInsets.all(sizeDefault);
    spacingAllSmall = EdgeInsets.all(sizeSmall);

    /*Screen Size dependent Constants*/
    screenWidthHalf = ScreenUtil.screenWidth / 2;
    screenWidthThird = ScreenUtil.screenWidth / 3;
    screenWidthFourth = ScreenUtil.screenWidth / 4;
    screenWidthFifth = ScreenUtil.screenWidth / 5;
    screenWidthSixth = ScreenUtil.screenWidth / 6;
    screenWidthTenth = ScreenUtil.screenWidth / 10;

    /*Image Dimensions*/

    defaultIconSize = ScreenUtil().setWidth(80.0).toDouble();
    defaultImageHeight = ScreenUtil().setHeight(120.0).toDouble();
    snackBarHeight = ScreenUtil().setHeight(50.0).toDouble();
    texIconSize = ScreenUtil().setWidth(30.0).toDouble();

    /*Default Height&Width*/
    defaultIndicatorHeight = ScreenUtil().setHeight(5.0).toDouble();
    defaultIndicatorWidth = screenWidthFourth;
  }
}

class FontSize {
  static double s7 = 7.0;
  static double s8 = 8.0;
  static double s9 = 9.0;
  static double s10 = 10.0;
  static double s11 = 11.0;
  static double s12 = 12.0;
  static double s13 = 13.0;
  static double s14 = 14.0;
  static double s15 = 15.0;
  static double s16 = 16.0;
  static double s17 = 17.0;
  static double s18 = 18.0;
  static double s19 = 19.0;
  static double s20 = 20.0;
  static double s21 = 21.0;
  static double s22 = 22.0;
  static double s23 = 23.0;
  static double s24 = 24.0;
  static double s25 = 25.0;
  static double s26 = 26.0;
  static double s27 = 27.0;
  static double s28 = 28.0;
  static double s29 = 29.0;
  static double s30 = 30.0;
  static double s36 = 36.0;

  static double setTextSize(double size) {
    return ScreenUtil().setSp(size).toDouble();
  }

  static setScreenAwareFontSize() {
    s7 = ScreenUtil().setSp(7.0).toDouble();
    s8 = ScreenUtil().setSp(8.0).toDouble();
    s9 = ScreenUtil().setSp(9.0).toDouble();
    s10 = ScreenUtil().setSp(10.0).toDouble();
    s11 = ScreenUtil().setSp(11.0).toDouble();
    s12 = ScreenUtil().setSp(12.0).toDouble();
    s13 = ScreenUtil().setSp(13.0).toDouble();
    s14 = ScreenUtil().setSp(14.0).toDouble();
    s15 = ScreenUtil().setSp(15.0).toDouble();
    s16 = ScreenUtil().setSp(16.0).toDouble();
    s17 = ScreenUtil().setSp(17.0).toDouble();
    s18 = ScreenUtil().setSp(18.0).toDouble();
    s19 = ScreenUtil().setSp(19.0).toDouble();
    s20 = ScreenUtil().setSp(20.0).toDouble();
    s21 = ScreenUtil().setSp(21.0).toDouble();
    s22 = ScreenUtil().setSp(22.0).toDouble();
    s23 = ScreenUtil().setSp(23.0).toDouble();
    s24 = ScreenUtil().setSp(24.0).toDouble();
    s25 = ScreenUtil().setSp(25.0).toDouble();
    s26 = ScreenUtil().setSp(26.0).toDouble();
    s27 = ScreenUtil().setSp(27.0).toDouble();
    s28 = ScreenUtil().setSp(28.0).toDouble();
    s29 = ScreenUtil().setSp(29.0).toDouble();
    s30 = ScreenUtil().setSp(30.0).toDouble();
    s36 = ScreenUtil().setSp(36.0).toDouble();
  }
}
