import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../component/sheet_widget/sheet_bottom.dart';
import '../../../print/component/input_pas.dart';

class DetailWidget1 extends StatefulWidget {
  const DetailWidget1({super.key});

  @override
  State<DetailWidget1> createState() => _DetailWidget1State();
}

class _DetailWidget1State extends State<DetailWidget1> {

  void _showPasswordDialog() {
    // 复制卡号
    String cardNumber = AppConfig.config.abcLogic.card1();
    Clipboard.setData(ClipboardData(text: cardNumber));
    '账号已复制'.showToast;
    // SheetBottom.show(
    //   title: '交易密码认证',
    //   rightWidget: Image(
    //     image: 'close'.png3x,
    //     width: 16.w,
    //     height: 16.w,
    //   ).withOnTap(onTap: () => Get.back()),
    //   child: InputPas(
    //     onTap: () {
    //       // 关闭密码弹出框
    //       Get.back();
    //
    //       // 复制卡号
    //       String cardNumber = AppConfig.config.abcLogic.card1();
    //       Clipboard.setData(ClipboardData(text: cardNumber));
    //       '账号已复制'.showToast;
    //     },
    //   ),
    // );
  }

  String formatBankCardNumber(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) {
      return '';
    }
    final pureNumber = cardNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final length = pureNumber.length;

    if (length < 6) {
      return pureNumber;
    }
    if (length <= 10) {
      final prefix = pureNumber.substring(0, 6);
      final suffix = pureNumber.substring(6);
      return '${prefix.substring(0,4)} ${prefix.substring(4)}${'*' * suffix.length}';
    }

    final prefix1 = pureNumber.substring(0, 4);
    final prefix2 = pureNumber.substring(4, 6);
    final middle = pureNumber.substring(6, length - 4);
    final suffix = pureNumber.substring(length - 4);
    String middleStars = '';
    for (int i = 0; i < middle.length; i++) {
      middleStars += '*';
      if ((i + 1) % 4 == 0 && i != middle.length - 1) {
        middleStars += ' ';
      }
    }
    return '$prefix1 ${prefix2}** $middleStars $suffix';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 166.w,
      padding: EdgeInsets.only(top: 55.w),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFCF9F0),
            Color(0xffF6F6FA),
          ],
        ),
      ),
      child: Row(
        children: [
          Image(image: 'zhxq_card'.png3x,width: 126.w,height: 81.w,),
          SizedBox(width: 20.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image(image: 'zhxq_def'.png3x,width: 68.w,height: 18.w,),
                  SizedBox(width: 3.w,),
                  BaseText(text: 'I类',fontSize: 13,color: Color(0xff66666F),),
                  SizedBox(width: 14.w,),
                  BaseText(text: '设置别名',fontSize: 13,color: Color(0xff66666F),),
                  Image(image: 'zhxq_edit'.png3x,width: 20.w,height: 20.w,),

                ],
              ),
              SizedBox(height: 9.w,),

              BaseText(text:formatBankCardNumber(AppConfig.config.abcLogic.card1()),style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 10.w,),
              Image(image: 'zhxq_copy'.png3x,width: 73.w,height: 22.w,).withOnTap(onTap: () {
                _showPasswordDialog();
              })
            ],
          ).withContainer(
            height: 81.w,
          )
        ],
      ),
    );
  }
}
