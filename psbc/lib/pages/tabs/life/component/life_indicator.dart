import 'package:flutter/material.dart';

class PreloadedImageTabIndicator extends Decoration {
  final ImageProvider image;
  final double width;
  final double height;

  late final ImageStream _imageStream;
  ImageInfo? _imageInfo;
  bool _isImageLoaded = false;

  PreloadedImageTabIndicator({
    required this.image,
    this.width = 29.0,  // 设置固定宽度29
    this.height = 8.0,  // 设置固定高度8
  }) {
    _loadImage();
  }

  void _loadImage() {
    final ImageStream stream = image.resolve(ImageConfiguration.empty);
    _imageStream = stream;
    stream.addListener(ImageStreamListener(
          (ImageInfo info, bool synchronousCall) {
        _imageInfo = info;
        _isImageLoaded = true;
      },
      onChunk: (ImageChunkEvent event) {},
      onError: (Object error, StackTrace? stackTrace) {
        debugPrint('Failed to load tab indicator image: $error');
      },
    ));
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _PreloadedImagePainter(this, onChanged);
  }
}

class _PreloadedImagePainter extends BoxPainter {
  final PreloadedImageTabIndicator decoration;

  _PreloadedImagePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    if (!decoration._isImageLoaded || decoration._imageInfo == null) {
      // 图片未加载时显示默认颜色
      final paint = Paint()..color = Colors.blue;
      final centerX = offset.dx + configuration.size!.width / 2;
      final rect = Rect.fromCenter(
        center: Offset(centerX, offset.dy + configuration.size!.height - decoration.height / 2),
        width: decoration.width,
        height: decoration.height,
      );
      canvas.drawRect(rect, paint);
      return;
    }

    final centerX = offset.dx + configuration.size!.width / 2;
    final indicatorRect = Rect.fromCenter(
      center: Offset(centerX, offset.dy + configuration.size!.height - decoration.height / 2),
      width: decoration.width,
      height: decoration.height,
    );

    paintImage(
      canvas: canvas,
      rect: indicatorRect,
      image: decoration._imageInfo!.image,
      fit: BoxFit.fill,
    );
  }
}