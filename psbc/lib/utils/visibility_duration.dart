import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VisibilityDetectorWrapper extends StatefulWidget {
  final Widget child;
  final String keyId;
  final Function(String keyId, bool isVisible)? onVisibilityChanged;
  final double visibilityThreshold;

  const VisibilityDetectorWrapper({
    super.key,
    required this.child,
    required this.keyId,
    this.onVisibilityChanged,
    this.visibilityThreshold = 0.5,
  });

  @override
  _VisibilityDetectorWrapperState createState() =>
      _VisibilityDetectorWrapperState();
}

class _VisibilityDetectorWrapperState
    extends State<VisibilityDetectorWrapper> {
  bool _lastVisibleState = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.keyId),
      onVisibilityChanged: (VisibilityInfo info) {
        final currentIsVisible =
            info.visibleFraction > widget.visibilityThreshold;
        if (currentIsVisible != _lastVisibleState) {
          _lastVisibleState = currentIsVisible;
          widget.onVisibilityChanged?.call(widget.keyId, currentIsVisible);
        }
      },
      child: widget.child,
    );
  }
}