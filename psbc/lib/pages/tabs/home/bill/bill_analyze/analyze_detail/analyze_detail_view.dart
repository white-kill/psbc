import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/sp_util.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'analyze_detail_logic.dart';
import 'analyze_detail_state.dart';

class AnalyzeDetailPage extends BaseStateless {
  AnalyzeDetailPage({Key? key}) : super(key: key,title: '收支分析');

  final AnalyzeDetailLogic logic = Get.put(AnalyzeDetailLogic());
  final AnalyzeDetailState state = Get.find<AnalyzeDetailLogic>().state;


  @override
  // TODO: implement rightAction
  List<Widget>? get rightAction => [
    Container(
      width: 55.w,
      alignment: Alignment.center,
      child: const BaseText(text: '管理'),
    ).withOnTap(onTap: () async{
      var map = Get.arguments;
      await logic.sendDataToWeb(map);
    })
  ];


  @override
  Widget initBody(BuildContext context) {
    return InAppWebView(
      initialFile: 'assets/dist/index.html',
      initialSettings: InAppWebViewSettings(
        scrollbarFadingEnabled: true,
        verticalScrollBarEnabled: false,
        horizontalScrollBarEnabled: false,
        overScrollMode: OverScrollMode.NEVER,
        allowsBackForwardNavigationGestures: true,
        allowFileAccess: true,
        allowContentAccess: true,
        javaScriptEnabled: true,
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
        cacheEnabled: true,
        supportZoom: false,
        mediaPlaybackRequiresUserGesture: false,
        useHybridComposition: true,
        allowsInlineMediaPlayback: true,
        allowsLinkPreview: false,
        mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
      ),
      onWebViewCreated: (controller) async {
        state.webViewController = controller;
        debugPrint('WebView创建完成');
        // 添加JavaScript处理器用于接收Web消息
        controller.addJavaScriptHandler(
          handlerName: 'FlutterChannel',
          callback: (args) {
            if (args.isNotEmpty) {
              final message = args[0].toString();
              logic.handleWebMessage(message);
            }
          },
        );
      },
      onLoadStart: (controller, url) {
        debugPrint('开始加载：$url');
      },
      onLoadStop: (controller, url) async {
        debugPrint('加载完成：$url');
        if (url.toString().contains('index.html') ||
            (!url.toString().contains('#') && url.toString().endsWith('/'))) {
          await logic.initRouter();
          await logic.injectBridge();
          await logic.sendTokenToWeb();
          Future.delayed(const Duration(milliseconds: 200),() async{
            var map = Get.arguments;
            await logic.sendDataToWeb(map);
          });
        }
      },
      onReceivedError: (controller, request, error) {
        debugPrint('加载失败：${request.url} | ${error.description}');
      },
      // 监听控制台日志（调试Vue报错）
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint('Vue控制台：${consoleMessage.message}');
      },
      // 处理导航请求
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        // 允许所有其他导航（让Vue Router自己处理）
        return NavigationActionPolicy.ALLOW;
      },
    );
  }
}
