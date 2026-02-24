import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'dart:io';
import '../../../../../../../config/model/receipt_model.dart';
import 'dzhd_info_state.dart';

class Dzhd_infoLogic extends GetxController {
  final Dzhd_infoState state = Dzhd_infoState();

  GlobalKey globalKey = GlobalKey();

  QrImage? qrImage;
  String code = '';

  @override
  void onInit() {
    super.onInit();

    state.detail = Get.arguments?['model'] ?? ReceiptListDetail();

    print(state.detail.toJson());
    print(state.detail.transactionLogno);
    print(state.detail.oppositeName);
    code = 'psbc656,${state.detail.transactionLogno},${state.detail.oppositeName}';
  }

  @override
  void onReady() {
    super.onReady();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final qrCode = QrCode(
        8,
        QrErrorCorrectLevel.L,
      )..addData(code);

      qrImage = QrImage(qrCode);

      update(['code']);
    });
  }

  String valueStr(String name) {
    switch (name) {
      case '回单号':
        return state.detail.transactionLogno;
      case '回单类型':
        return state.detail.transactionType;
      case '付款账号':
        return state.detail.bankCard.maskBankCardNumber(
          prefixLength: 6,
          fixStr: ' ',
          maskCharCount: 6,
        );
      case '收款人':
        return state.detail.oppositeName;
      case '收款账号':
        return state.detail.oppositeAccount.maskBankCardNumber(
          prefixLength: 6,
          fixStr: ' ',
          maskCharCount: 6,
        );
      case '收款人开户行转账金额(大写)':
        return state.detail.capitalLettersAmount;
      case '附言':
        return state.detail.merchantBranch;
      case '手续费':
        return '¥0.00';
      case '转账渠道':
        return state.detail.transactionChannel;
      case '交易日期':
        return state.detail.transactionTime;
      case '打印日期':
        return state.detail.printTime;
      default:
        return '';
    }
  }

  // 保存整个页面为图片
  Future<void> saveFullPageAsImage() async {
    try {
      // 等待一帧确保界面完全渲染
      await Future.delayed(Duration(milliseconds: 100));

      // 获取 RenderObject
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // 转换为图片（提高像素比获得更清晰的图片）
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // 转换为字节数据
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      savePngImage(pngBytes).then((v) {
        '保存成功'.showToast;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future savePngImage(Uint8List value) async {
    // 获取应用的临时目录
    final directory = await getTemporaryDirectory();
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    // 为图片创建文件路径
    final filePath =
        '${directory.path}/ccb_${timestamp.toString()}_${DateTime.now().millisecondsSinceEpoch}.png';

    // 创建文件并将 Uint8List 写入文件
    final file = File(filePath);
    await file.writeAsBytes(value);
    // 使用 gallery_saver 插件将图片保存到相册
    return GallerySaver.saveImage(filePath);
  }
}
