import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/tabs/home/account/detail/detail_view.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../other/change_nav/change_nav_view.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';
import '../../bill/bill_view.dart';
import '../../transfer/transfer_view.dart';
import '../../jijin/jijin_view.dart';

class CardInfo extends StatefulWidget {
  const CardInfo({super.key});

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  String formatBankCardWithRegex(String cardNumber) {
    if (cardNumber.isEmpty) return '';
    String cleaned = cardNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length < 16) {
      return cardNumber;
    }
    try {
      RegExp regex = RegExp(r'^(\d{4})(\d{2})\d+(\d{4})$');

      if (regex.hasMatch(cleaned)) {
        Match match = regex.firstMatch(cleaned)!;
        String part1 = match.group(1)!;
        String part2 = match.group(2)!;
        String part5 = match.group(3)!;
        return '$part1 $part2** *** *** $part5';
      }
      return cardNumber;
    } catch (e) {
      return cardNumber;
    }
  }

  // 格式化银行卡号：每4个一个空格，最后只剩3个
  String formatBankCardNumber(String cardNumber) {
    if (cardNumber.isEmpty) return '';
    String cleaned = cardNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length <= 3) return cleaned;

    StringBuffer result = StringBuffer();
    int length = cleaned.length;

    // 处理前面的部分，每4个一个空格
    int fullGroupCount = (length - 3) ~/ 4;
    int firstGroupSize = (length - 3) % 4;

    int index = 0;

    // 如果第一组不是4个，先处理第一组
    if (firstGroupSize > 0) {
      result.write(cleaned.substring(0, firstGroupSize));
      result.write(' ');
      index = firstGroupSize;
    }

    // 处理完整的4位一组
    for (int i = 0; i < fullGroupCount; i++) {
      result.write(cleaned.substring(index, index + 4));
      result.write(' ');
      index += 4;
    }

    // 处理最后3位
    result.write(cleaned.substring(index, index + 3));
    result.write(' ');
    result.write(cleaned.substring(index + 3));

    return result.toString();
  }

  void alter() {
    // SheetBottom.show(
    //   title: '交易密码认证',
    //   rightWidget: Image(
    //     image: 'close'.png3x,
    //     width: 16.w,
    //     height: 16.w,
    //   ).withOnTap(onTap: () => Get.back()),
    //   child: InputPas(
    //     onTap: () {
    //       // 关闭当前弹出框
    //       Get.back();
    //
    //       // 弹出新的底部弹出框
    //       _showCopyBottomSheet();
    //     },
    //   ),
    // );
    // 弹出新的底部弹出框
    _showCopyBottomSheet();
  }

  void _showCopyBottomSheet() {
    Get.bottomSheet(
      Container(
        width: 1.sw,
        color: Colors.transparent,
        child: Stack(
          children: [
            // 背景图片
            Image(
              image: 'copy_bottom'.png3x,
              width: 1.sw,
              fit: BoxFit.fitWidth,
            ).withOnTap(onTap: () => Get.back()),

            // 银行卡号
            Positioned(
              top: 60.w,
              left: 80.w,
              child: BaseText(
                text: formatBankCardNumber(AppConfig.config.abcLogic.card1()),
                fontSize: 16,
                color: Color(0xff333333),
              ),
            ),

            // 姓名
            Positioned(
              top: 100.w,
              left: 80.w,
              child: BaseText(
                text: AppConfig.config.abcLogic.memberInfo.realName,
                fontSize: 16,
                color: Color(0xff333333),
              ),
            ),

            // 左边按钮 - 复制全部信息
            Positioned(
              bottom: 0.w,
              left: 0.w,
              child: Container(
                width: 1.sw / 2.0,
                height: 50.w,
              ).withOnTap(onTap: () {
                // 复制全部信息
                String allInfo =
                    '账号：${AppConfig.config.abcLogic.card1()}\户名：${AppConfig.config.abcLogic.memberInfo.realName}';
                Clipboard.setData(ClipboardData(text: allInfo));
                '全部信息复制成功'.showToast;
                Get.back();
              }),
            ),

            // 右边按钮 - 复制账户
            Positioned(
              bottom: 0.w,
              right: 0.w,
              child: Container(
                width: 1.sw / 2.0,
                height: 50.w,
              ).withOnTap(onTap: () {
                // 复制账户
                Clipboard.setData(
                    ClipboardData(text: AppConfig.config.abcLogic.card1()));
                '账号已复制'.showToast;
                Get.back();
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      isDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'account_tag1_2'.png3x).withOnTap(onTap: () {
          Get.to(() => DetailPage());
        }),
        // Positioned(
        //   top: 35.w,
        //   left: 15.w,
        //   child: BaseText(
        //     text: '借记账户（1）',
        //     fontSize: 16.sp,
        //   ),
        // ),
        Positioned(
          top: 94.w,
          left: 32.w,
          child: Image(
            image: 'ic_yzyh'.png3x,
            width: 136.w,
            height: 30.w,
          ),
        ),
        Positioned(
          top: 128.w,
          left: 33.w,
          child: BaseText(
            text: formatBankCardWithRegex(AppConfig.config.abcLogic.card1()),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
            top: 120.w,
            right: 33.w,
            child: Container(
              width: 80.w,
              height: 40.w,
            ).withOnTap(onTap: () => alter())),
        // Positioned(
        //     top: 161.w,
        //     left: 33.w,
        //     child: Row(
        //       children: [
        //         Container(
        //           width: 28.w,
        //           height: 20.w,
        //           decoration: BoxDecoration(
        //             color: Color(0xffE6F0EB),
        //             borderRadius: BorderRadius.all(
        //               Radius.circular(4.w),
        //             ),
        //           ),
        //           alignment: Alignment.center,
        //           child: BaseText(
        //             text: 'I类',
        //             style: TextStyle(fontSize: 12.sp, color: BColors.mainColor),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10.w,
        //         ),
        //         Container(
        //           width: 50.w,
        //           height: 20.w,
        //           decoration: BoxDecoration(
        //             color: Color(0xffE6F0EB),
        //             borderRadius: BorderRadius.all(
        //               Radius.circular(4.w),
        //             ),
        //           ),
        //           alignment: Alignment.center,
        //           child: BaseText(
        //             text: '借记卡',
        //             style: TextStyle(fontSize: 12.sp, color: BColors.mainColor),
        //           ),
        //         ),
        //       ],
        //     )),
        Positioned(
            top: 210.w,
            left: 90.w,
            child: Row(
              children: [
                // BaseText(
                //   text: '可用余额 ',
                //   color: Color(0xff666666),
                // ),
                BaseText(
                  text: '￥${AppConfig.config.abcLogic.balance()}',
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                )
              ],
            )),
        Positioned(
            bottom: 6.w,
            left: 0,
            child: Container(
              width: 1.sw - 32.w,
              height: 45.w,
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  Container().expanded(onTap: () {
                    Get.to(() => BillPage());
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => TransferPage());
                  }),
                  Container().expanded(onTap: () {
                    Get.to(() => ChangeNavPage(),
                        arguments: {'image': 'a_lc', 'title': '购买理财'});
                  }),
                  Container().expanded(onTap: () {
                    // Get.to(() => FixedNavPage(),arguments: {
                    //   'image':'home_jijin',
                    //   'title':'基金'
                    // });
                    Get.to(() => JijinPage());
                  }),
                ],
              ),
            ))
      ],
    );
  }
}
