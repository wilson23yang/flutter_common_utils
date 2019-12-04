library commonutils;

import 'package:common_utils/utils/adaptive_util.dart';
import 'package:flutter/widgets.dart';


export 'package:common_utils/utils/adaptive_util.dart';
export 'package:common_utils/utils/dialog_util.dart';
export 'package:common_utils/utils/show_dialog_util.dart';
export 'package:common_utils/utils/toast_util.dart';


class CommonUtils {

  static void init(BuildContext context){
    _initAdaptive(context);
  }

  static void _initAdaptive(BuildContext context){
    Adaptive.size = context.size;
  }

}