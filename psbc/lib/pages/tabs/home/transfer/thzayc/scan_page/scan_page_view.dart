import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import 'scan_page_logic.dart';
import 'scan_page_state.dart';

class ScanPage extends StatelessWidget {
  ScanPage({Key? key}) : super(key: key);

  final ScanPageLogic logic = Get.put(ScanPageLogic());
  final ScanPageState state = Get.find<ScanPageLogic>().state;

  void onQRViewCreated(QRViewController controller) {
    state.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // 扫码成功，返回结果
      Get.back(result: scanData.code);
      (scanData.code ?? '').showToast;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final maxSize = screenSize.longestSide * 2; // 确保覆盖整个屏幕
    
    return Stack(
      children: [
        // 全屏摄像头
        Positioned.fill(
          child: Expanded(
            child: QRView(
              key: state.qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.transparent,
                borderRadius: 0,
                borderLength: 0,
                borderWidth: 0,
                cutOutSize: maxSize,
                overlayColor: Colors.transparent,
              ),
            ),
          ),
        ),

        // 中间扫描框图片
        Center(
          child: Transform.rotate(
            angle: 1.5708, // 90度 = π/2 弧度
            child: Image(
              image: AssetImage('assets/images/scan_main@3x.png'), // 注意文件名中有空格
              width: 1.sh - 50.w,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),

        // 底部三个图标
        Positioned(
          left: 0,
          right: 0,
          bottom: 30.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomIcon('scan_3'),
              _buildBottomIcon('scan_2'),
              _buildBottomIcon('scan_1'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomIcon(String imageName) {
    return Transform.rotate(
      angle: 1.5708, // 90度 = π/2 弧度
      child: Image(
        image: imageName.png3x,
        width: 30.w,
        height: 30.w,
      ),
    ).withOnTap(onTap: () {
      // TODO: 处理底部图标点击事件
      Get.back();
    });
  }
}
