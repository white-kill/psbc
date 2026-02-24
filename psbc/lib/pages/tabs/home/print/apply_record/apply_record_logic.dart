import 'package:get/get.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/model/apply_record_model.dart';
import 'package:psbc/config/net_config/apis.dart';

import 'apply_record_state.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';

class ApplyRecordLogic extends GetxController {
  final ApplyRecordState state = ApplyRecordState();

  @override
  void onInit() {
    super.onInit();
    flowExportApplyPage();
  }

  void flowExportApplyPage(){
    Http.get(Apis.flowExportApplyPage,queryParameters: {
      'pageSize':10,
      'pageNum':state.pageNum
    }).then((v){
      state.recordModel = ApplyRecordModel.fromJson(v);
      state.refreshController.loadComplete();
      if (!state.recordModel.list.isNotEmpty) {
        state.refreshController.loadNoData();
      }
      if (state.pageNum == 1) {
        state.list = state.recordModel.list;
      } else {
        state.list = state.list + state.recordModel.list;
      }
      update(['updateUI']);
    });
  }

  String valueStr(String name,ApplyRecordList model) {
    switch (name) {
      case '申请日期':
        return model.createTime;
      case '获取方式':
        return model.email == ''?'本地下载':'发送邮箱';
      case '文件提取码':
        return model.isShow? model.code : '******';
      case '邮件序列号':
        return model.busNo;
      case '截止时间':
        return model.endTime.split(' ').first;
      case '起始时间':
        return model.beginTime.split(' ').first;
      case '接收邮箱':
        return model.email;
      default:
        return '';
    }
  }

  Future<void> downloadAndOpenPDF(String url, String fileName) async {
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String filePath = "${tempDir.path}/$fileName";
      File file = File(filePath);

      if (await file.exists()) {
        print("文件已存在，直接打开");
        await OpenFilex.open(filePath);
        return;
      }

      print("开始下载...");
      Dio dio = Dio();
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("进度: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      // 4. 下载完成，打开文件
      print("下载完成，正在打开...");
      await OpenFilex.open(filePath);

    } catch (e) {
      print("发生错误: $e");
    }
  }
}
