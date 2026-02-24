import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:psbc/config/dio/network.dart';
import 'package:psbc/config/net_config/apis.dart';
import 'package:psbc/pages/tabs/home/print/print_result/print_result_view.dart';
import 'package:wb_base_widget/component/count_down_btn.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../../../config/app_config.dart';
import '../../../../../utils/color_util.dart';
import '../../../../../utils/local_notifications.dart';
import '../req_print.dart';

class InputCode extends StatefulWidget {
  final ReqPrint reqPrint;

  const InputCode({super.key, required this.reqPrint});

  @override
  State<InputCode> createState() => _InputCodeState();
}

class _InputCodeState extends State<InputCode> {
  CountDownBtnController downBtnController = CountDownBtnController();

  String code = Random().nextVerificationCode(6);
  String code1 = Random().nextVerificationCode(4);
  String name = AppConfig.config.abcLogic.cardFour();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      downBtnController.click();
      NotificationHelper.getInstance().showNotification(
          title: "邮政银行",
          body:
          "【邮储银行】验证码:$code(序号$code1)您尾号$name账户正在申请下载交易流水、请确保本人操作并保护好个人隐私信息，谨防诈骗",
          payload: "payload");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildSmsTipText(
              phoneNumber: AppConfig.config.abcLogic.memberInfo.phone
                  .desensitize(),
              validTime: '3分钟',
              serialNumber: code1).withPadding(
            left: 12.w,right: 12.w,top: 12.w,bottom: 24.w,
          ),

          Pinput(
            length: 6,
            separatorBuilder: (index) => SizedBox(width: 8.w),
            onCompleted: (pin) {
              Map<String,dynamic> data = widget.reqPrint.toJson();
              print(data);
              Http.post(Apis.flowExportPrint,data: data,).then((v){
                if(v != null){
                  Get.back();
                  Get.to(() => PrintResultPage(),arguments: {
                    'req':widget.reqPrint,
                  });
                }
              });
            },
            defaultPinTheme: PinTheme(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: Color(0xffdedede).withOpacity(0.4),
                borderRadius: BorderRadius.circular(2.w),
              ),
            ),
          ).withPadding(
            left: 12.w,
            right: 12.w,
          ),
          WzhCountDownBtn(
            controller: downBtnController,
            showBord: false,
            textColor: Colors.black,
            getVCode: () async {
              return true;
            },
          ).withPadding(right: 12.w).withContainer(
            width: 1.sw,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 12.w),
          )
        ],
      ),
    );
  }

  RichText buildSmsTipText({
    required String phoneNumber,
    required String validTime,
    required String serialNumber,
  }) {
    // 基础样式（其余文本默认灰色，可自定义）
    const baseStyle = TextStyle(
      fontSize: 13,
      color: Color(0xFF666666),
      height: 1.4, // 行高，提升可读性
    );

    // 红色高亮样式（手机号+时效用）
    const highlightRedStyle = TextStyle(
      fontSize: 13,
      color: BColors.mainColor, // 核心：红色
      height: 1.4,
    );

    // 拆分文本为多个片段，分别设置样式
    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: "已将序号为"),
          TextSpan(text: serialNumber), // 序号用基础样式（默认灰色）
          const TextSpan(text: "的短信验证码发送到"),
          TextSpan(text: phoneNumber, style: highlightRedStyle), // 手机号标红
          const TextSpan(text: "手机号码上，验证码"),
          TextSpan(text: validTime, style: highlightRedStyle), // 3分钟标红
          const TextSpan(text: "内有效，请查收"),
        ],
      ),
      // textAlign: TextAlign.center, // 居中对齐（适合提示类文案）
    );
  }
}
