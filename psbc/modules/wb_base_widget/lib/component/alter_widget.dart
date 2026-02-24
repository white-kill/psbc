import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AlterWidget {
  static alterWidget({
    required Widget Function(BuildContext context) builder,
    bool clickMaskDismiss = false,
    Alignment? alignment,
    bool? useAnimation,
  }) {
    SmartDialog.show(
      usePenetrate: false,
      clickMaskDismiss: clickMaskDismiss,
      alignment: alignment,
      useAnimation: useAnimation,
      builder: builder,
    );
  }
}
