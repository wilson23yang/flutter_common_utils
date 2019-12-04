import 'package:common_utils/utils/adaptive_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(String message, {bool longToast = false}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: ' $message ',
        toastLength: longToast ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        backgroundColor: Color(0xFF393939),
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        textColor: Colors.white70,
        fontSize: Adaptive.font(15.5));
  }


  static Future showToastDialog(
      {@required BuildContext context,
        String icon,
        String content,
        String subContent,
        bool barrierDismissible = true,
        Duration duration = const Duration(milliseconds: 1000)}) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) {
        final ThemeData theme = Theme.of(buildContext, shadowThemeOnly: true);
        final Widget pageChild = Builder(builder: (context) {
          return _ToastDialog(
            icon: icon,
            content: content,
            subContent: subContent,
          );
        });
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0x01000000),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    ).timeout(duration, onTimeout: () {
      Navigator.of(context).pop();
    });
  }

  //防止提交多个自定义Toast不会自动消失
  // static bool toastShowing = false;

  ///自定义Toast样式
  static Future showToast({
    @required BuildContext context,
    @required title,
    @required imagePath,
    Duration duration,
  }) {
    return ToastUtil.showMyToastDialog(
      context: context,
      childWidget: _UploadDialogWidget(
        title: '$title',
        imagePath: imagePath,
      ),
      duration: Duration(milliseconds: 1000),
    );
  }

  static Future showMyToastDialog({
    @required BuildContext context,
    @required Widget childWidget,
    Duration duration,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
        final Widget pageChild = Builder(builder: (context) {
          return childWidget;
        });
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0x01000000),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    ).timeout(duration, onTimeout: () {
      print('time out');
      // toastShowing = false;
      Navigator.of(context).pop();
    });
  }
}


Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}



class _ToastDialog extends StatelessWidget {
  final String icon;
  final String content;
  final String subContent;

  _ToastDialog({this.content, this.icon, this.subContent});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            color: Color(0xFF6288B4),
            elevation: 0,
            margin: EdgeInsets.all(
              Adaptive.width(62),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Adaptive.width(5))),
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      (icon?.isNotEmpty ?? false)
                          ? Image.asset(icon)
                          : Container(
                        width: 0,
                        height: 0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: Adaptive.width(7.33)),
                          child: Text(
                            content,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: Adaptive.width(13.33),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  subContent != null
                      ? Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: Adaptive.width(7)),
                      child: Text(
                        subContent,
                        style: TextStyle(
                          fontSize: Adaptive.width(10.67),
                          color: Color(0xFFD4DCF0),
                        ),
                      ))
                      : Container(
                    height: 0,
                    width: 0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadDialogWidget extends StatelessWidget{
  final String imagePath;
  final String title;
  final String content;

  _UploadDialogWidget({this.content='', this.imagePath,this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
          color: Color(0xFF6288B4),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Adaptive.width(3))),
          child: Container(
            width: Adaptive.width(253),
            padding: EdgeInsets.symmetric(vertical: Adaptive.width(13.33)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(imagePath),
                    SizedBox(width: Adaptive.width(7.33),),
                    Text(title, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: Adaptive.width(13.33),fontWeight: FontWeight.bold),),
                  ],
                ),
                content==''?SizedBox():Padding(
                  padding: EdgeInsets.only(top: Adaptive.width(11.33)),
                  child: Text(content, style: TextStyle(color: Color(0xFFD4DCF0), fontSize: Adaptive.width(10.67),),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

}
