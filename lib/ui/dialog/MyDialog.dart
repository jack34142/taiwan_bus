import 'package:flutter/material.dart';

class MyDialog extends Dialog {

  final EdgeInsets padding;
  final double minWidth;
  final BorderRadius borderRadius;
  final bool barrierDismissible;

  const MyDialog({
    Key key,
    backgroundColor,
    insetAnimationDuration = const Duration(milliseconds: 100),
    insetAnimationCurve = Curves.decelerate,
    child,
    this.padding : const EdgeInsets.all(0),
    this.minWidth : double.infinity,
    this.borderRadius,
    this.barrierDismissible : true,
  }) : super(
      key: key,
      backgroundColor: backgroundColor,
      insetAnimationDuration: insetAnimationDuration,
      insetAnimationCurve: insetAnimationCurve,
      child: child
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: AnimatedPadding(
          padding: padding,
          duration: insetAnimationDuration,
          curve: insetAnimationCurve,
          child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: minWidth),
                  child: Material(
                    color: Colors.transparent,
                    child: ClipRRect(
                        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
                        child: Container(
                          color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                          child: child,
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return barrierDismissible;
        }
    );
  }
}