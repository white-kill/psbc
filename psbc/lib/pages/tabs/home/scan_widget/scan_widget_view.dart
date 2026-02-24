import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/scan_widget/scan_an_widget.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../config/dio/network.dart';
import '../../../../config/model/receipt_model.dart';
import '../../../../config/net_config/apis.dart';
import '../../../../routes/app_pages.dart';
import '../transfer/dzhd/dzhd_list/dzhd_info/dzhd_info_view.dart';
import 'scan_widget_logic.dart';
import 'scan_widget_state.dart';

class ScanWidgetPage extends BaseStateless {
  ScanWidgetPage({Key? key}) : super(key: key, title: '扫一扫');

  final Scan_widgetLogic logic = Get.put(Scan_widgetLogic());
  final Scan_widgetState state = Get.find<Scan_widgetLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Color? get navColor => Color(0xff333333);

  @override
  Color? get titleColor => Colors.white;
  @override
  Color? get backColor => Colors.white;

  @override
  List<Widget>? get rightAction => [
        BaseText(
          text: '相册',
          fontSize: 15,
          color: Colors.white,
        ).withContainer(
            padding: EdgeInsets.only(right: 12.w),
            alignment: Alignment.center,
        )
      ];

  void onQRViewCreated(QRViewController controller) {
    state.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      String data = scanData.code??'';
      if(data.contains('psbc656')){
        state.controller?.pauseCamera();
        List dataList = data.split(',');
        if(dataList.length > 1){
          Http.post(Apis.checkReceipt,data: {
            "no":dataList[1],
            "realName":dataList[2],
          }).then((v){
            ReceiptListDetail model = ReceiptListDetail.fromJson(v);
            Get.offAndToNamed(Routes.dzhdInfoPage,arguments: {
              'model':model
            });
          });
        }
      }
    });
  }

  @override
  Widget initBody(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final screenHeight = constraints.maxHeight;
                final scanAreaSize = screenWidth * 0.6;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    QRView(
                      key: state.qrKey,
                      onQRViewCreated: onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.green.shade400,
                        borderRadius: 4,
                        borderLength: 20.w,
                        borderWidth: 4,
                        cutOutSize: scanAreaSize,
                      ),
                    ),

                    // 扫描线动画 - 居中在扫描区域
                    // Positioned(child: child)

                    Positioned(
                        child: Container(
                      width: screenWidth * 0.55,
                      height: screenWidth * 0.55,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          ScannerAnimation(containerSize: scanAreaSize),
                        ],
                      ),
                    )),
                    //

                    // 闪光灯按钮 - 放在扫描框上方
                    Positioned(
                      top: (screenHeight - scanAreaSize) / 2 + 240.w,
                      child: Column(
                        children: [
                          Image(
                            image: 'icon_sdt'.png3x,
                            width: 32.w,
                            height: 32.w,
                          ),
                          BaseText(
                            text: '轻触照亮',
                            color: Colors.white,
                          ),
                        ],
                      ).withOnTap(onTap: () {
                        state.controller?.toggleFlash();
                      }),
                    ),

                    // 提示文字 - 放在扫描框下方
                    Positioned(
                      top: (screenHeight + scanAreaSize) / 2 - 50.w,
                      child: BaseText(
                        text: '请将二维码置于框中',
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),

                    Positioned(left: 0,bottom: 60.w,child: Row(
                      children: [
                        Expanded(child: _customWidget('ic_skm', "付款码")),
                        Expanded(child: _customWidget('ic_skm', "收款码")),
                        Expanded(child: _customWidget('ic_xwzz', "向我转账")),
                        Expanded(child: _customWidget('ic_skm', "交通出行")),
                      ],
                    ).withContainer(
                      width: 1.sw,
                      height: 68.w
                    ))
                  ],
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _customWidget(String imgName, String title) {
    return Column(
      children: [
        Image(
          width: 45.w,
          height: 45.w,
          image: imgName.png3x,
          color: Colors.white,
        ),
        SizedBox(height: 6.w,),
        Text(title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
            )),
      ],
    ).paddingOnly(right: 10.w,left: 10.w);
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
