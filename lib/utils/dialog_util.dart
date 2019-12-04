import 'package:common_utils/utils/adaptive_util.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static void showSimpleDialog({
    @required BuildContext context,
    String title,
    @required String content,
    String confirmText,
    Function confirmCallback,
    Alignment titleAlignment,
    Widget child,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return _CustomDialog(
            title: title,
            content: content,
            confirmText: confirmText,
            confirmCallback: confirmCallback,
            titleAlignment: titleAlignment,
            hideCancelBtn: true,
            child: child,
          );
        });
  }

  static void showActionDialog(
      {@required BuildContext context,
      String title,
      @required String content,
      String cancelText,
      String confirmText,
      Function cancelCallback,
      Function confirmCallback,
      Alignment titleAlignment,
      Alignment contentAlignment,
      Widget child,
      bool hideTitle = false}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return _CustomDialog(
            title: title,
            content: content,
            cancelText: cancelText,
            confirmText: confirmText,
            cancelCallback: cancelCallback,
            confirmCallback: confirmCallback,
            titleAlignment: titleAlignment,
            child: child,
            hideTitle: hideTitle,
            contentAlignment: contentAlignment,
          );
        });
  }

}



class _CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final Function cancelCallback;
  final Function confirmCallback;
  final Alignment titleAlignment;
  final Alignment contentAlignment;
  final bool hideCancelBtn;
  final bool hideTitle;
  final Widget child;

  _CustomDialog({
    this.title,
    this.content,
    this.cancelText,
    this.confirmText,
    this.cancelCallback,
    this.confirmCallback,
    this.titleAlignment,
    this.contentAlignment,
    this.hideCancelBtn = false,
    this.hideTitle = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            color: Color(0xFF184579),
            elevation: 0,
            margin: EdgeInsets.all(
              Adaptive.width(30),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Adaptive.width(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: titleAlignment ?? Alignment.center,
                  padding: EdgeInsets.only(
                    top: Adaptive.width(19),
                    bottom: Adaptive.width(13),
                    left: Adaptive.width(12),
                    right: Adaptive.width(12),
                  ),
                  child: hideTitle
                      ? Container(width: 0, height: 0)
                      : Text(
                    title ?? '提示',
                    style: TextStyle(
                      color: Color(0xFFD4DCF0),
                      fontSize: Adaptive.width(15),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  alignment: contentAlignment ?? Alignment.topLeft,
                  padding: EdgeInsets.only(
                    top: Adaptive.width(13),
                    bottom: Adaptive.width(15),
                    left: Adaptive.width(12),
                    right: Adaptive.width(12),
                  ),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: Color(0xFFD4DCF0),
                      fontSize: Adaptive.width(15),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: child ??
                      Container(
                        height: 0,
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Adaptive.width(15),
                    bottom: Adaptive.width(12),
                    left: Adaptive.width(8),
                    right: Adaptive.width(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                        visible: !hideCancelBtn,
                        child: Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: Adaptive.width(4),
                              right: Adaptive.width(4),
                            ),
                            child: FlatButton(
                              color: Color(0xFF42759C),
                              padding: EdgeInsets.only(
                                bottom: Adaptive.width(12),
                                top: Adaptive.width(12),
                              ),
                              child: Text(
                                cancelText ??
                                    '取消',
                                style: TextStyle(
                                  color: Color(0xFFD4DCF0),
                                  fontSize: Adaptive.width(14),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (cancelCallback != null) {
                                  cancelCallback();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: Adaptive.width(4),
                            right: Adaptive.width(4),
                          ),
                          child: FlatButton(
                            color: Color(0xFFD4DCF0),
                            padding: EdgeInsets.only(
                              bottom: Adaptive.width(12),
                              top: Adaptive.width(12),
                            ),
                            child: Text(
                              confirmText ??
                                  '确定',
                              style: TextStyle(
                                color: Color(0xFF0F1928),
                                fontSize: Adaptive.width(14),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (confirmCallback != null) {
                                confirmCallback();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
