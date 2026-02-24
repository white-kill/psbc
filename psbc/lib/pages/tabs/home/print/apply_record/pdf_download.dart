import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class PdfDownloadService {
  /// 1. 核心修改：通过 URL 生成唯一文件名
  static String _generateUniqueFileName(String url) {
    // 按照 '/' 分割 url
    List<String> segments = url.split('/');
    if (segments.length >= 2) {
      // 取最后两部分：20260116113816 和 邮储银行...pdf
      String folderName = segments[segments.length - 2];
      String fileName = segments.last;
      // 拼接成：20260116113816_邮储银行历史明细（20250716-20260116）.pdf
      return "${folderName}_$fileName";
    }
    return segments.last; // 保底方案
  }

  /// 2. 获取本地存储全路径
  static Future<String> _getFilePath(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    String uniqueName = _generateUniqueFileName(url);
    return "${directory.path}/$uniqueName";
  }

  /// 3. 判断文件是否已经下载过
  static Future<bool> isFileDownloaded(String url) async {
    String path = await _getFilePath(url);
    return await File(path).exists();
  }

  /// 4. 处理下载或打开逻辑
  static Future<void> handlePdfAction(String url) async {
    String savePath = await _getFilePath(url);
    bool isExist = await File(savePath).exists();

    if (isExist) {
      await OpenFilex.open(savePath);
    } else {
      try {
        // 对于带中文的URL，建议进行编码转换，防止下载报错
        String encodedUrl = Uri.encodeFull(url);
        await Dio().download(encodedUrl, savePath);
        await OpenFilex.open(savePath);
      } catch (e) {
        print("操作失败: $e");
      }
    }
  }
}
