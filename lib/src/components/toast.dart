import 'package:flutter/material.dart';

class Toast {
  static void show(String message, BuildContext context, {int duration,double top,double bottom}) {
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom:bottom ,
        left: 0,
        right: 0,
        top: top,
        child: Center(
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context).insert(entry);
    Future.delayed(Duration(seconds: duration ?? 2)).then((value) {
      // 移除层可以通过调用OverlayEntry的remove方法。
      entry.remove();
    });
  }
}
