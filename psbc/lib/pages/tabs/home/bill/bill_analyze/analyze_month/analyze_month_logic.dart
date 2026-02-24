import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/sp_util.dart';
import 'package:wb_base_widget/extension/string_extension.dart';

import 'analyze_month_state.dart';

class AnalyzeMonthLogic extends GetxController {
  final AnalyzeMonthState state = AnalyzeMonthState();

  Future<void> injectBridge() async {
    if (state.webViewController == null) return;

    await state.webViewController!.evaluateJavascript(source: '''
      (function() {
        if (window.FlutterBridge) return; // 避免重复注入

        window.FlutterBridge = {
          postMessage: function(message) {
            if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
              window.flutter_inappwebview.callHandler('FlutterChannel', JSON.stringify(message));
            }
          },

          _dispatch: function(action, data) {
            console.log('Action from Flutter:', action, data);
            window.dispatchEvent(new CustomEvent('flutter_' + action, { detail: data }));
          }
        };
        console.log('FlutterBridge Initialized');
      })();
    ''');
  }

  Future initRouter() async {
    if (state.webViewController == null) return;
    await state.webViewController!.evaluateJavascript(source: '''
      if (window.vueRouter) {
        window.vueRouter.push('/psbc/anaysis').catch(err => {
          console.error('路由跳转失败:', err);
        });
      } 
      else if ('/'.startsWith('/psbc/anaysis')) {
        window.location.hash = '#/';
      }
      else {
        window.location.pathname = '/psbc/anaysis';
      }
    ''');
  }

  /// 处理从web接收到的消息
  void handleWebMessage(String message) {
    try {
      final data = jsonDecode(message) as Map<String, dynamic>;
      debugPrint('收到Web消息:$data');
      // state.dataMap['dateTime'] = data['data'];
    } catch (e) {
      debugPrint('解析Web消息失败: $e');
      debugPrint('原始消息: $message');
    }
  }

  Future<void> sendTokenToWeb() async {
    if (state.webViewController == null) return;
    String tokenJson = jsonEncode(token);
    await state.webViewController!.evaluateJavascript(
        source: 'window.FlutterBridge._dispatch("setToken", $tokenJson);');
  }

  Future<void> sendDataToWeb(Map<String, dynamic> data) async {
    if (state.webViewController == null) return;

    String jsonStr = jsonEncode(data);
    await state.webViewController!.evaluateJavascript(
        source: 'window.FlutterBridge._dispatch("onMessage", $jsonStr);');
  }

  Future<void> executeCustomJS() async {
    if (state.webViewController == null) return;

    await state.webViewController!.evaluateJavascript(source: '''
      // 在这里可以执行任何Vue应用中的方法
      if (typeof window.customFunction === 'function') {
        window.customFunction();
      }
    ''');
  }

  @override
  void onInit() {
    super.onInit();
    // state.dataMap = Get.arguments;
    ''.showLoading;
    Future.delayed(const Duration(milliseconds: 400), () async {
      await SmartDialog.dismiss(status: SmartStatus.loading);
    });
  }
}
