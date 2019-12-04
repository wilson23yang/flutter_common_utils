import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// 屏幕适配工具类
class Adaptive {
  static Size size;
  static double devicePixelRatio;

  /// 默认设计稿采用iphone8尺寸，宽为750像素，Scale Factor 2x
  /// 默认设计稿宽为1080像素，Scale Factor 3x
  static double width(double width) {
    return min(size.width, size.height) * width / 360.0;
  }

  /// 适配字体
  static double font(double font) {
    return min(size.width, size.height) * font / 360.0;
  }

  static bool isIphoneX(Size size) {
    // iOS尺寸 x、xr、xs max宽高比都大于2.16
    if (Platform.isIOS) {
      return size.height / size.width > 2.16;
    } else {
      return false;
    }
  }

  static double get splitWidth {
    devicePixelRatio =
        (devicePixelRatio == 0 ? 1 : devicePixelRatio); // avoid divide zero
    return 1 / devicePixelRatio;
  }
}
