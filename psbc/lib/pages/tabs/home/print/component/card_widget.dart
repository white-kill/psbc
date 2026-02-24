import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  
  void _showCardBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Image(
                image: 'print_bottom_1'.png3x,
                width: 1.sw,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              left: 60,
              top: 70.w,
              child: BaseText(
                text: AppConfig.config.abcLogic.card1().maskBankCardNumber(
                  prefixLength: 6,
                  fixStr: ' ',
                  maskCharCount: 6,
                ),
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 52.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, right: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText(text: '帐号'),
          BaseText(
              text: AppConfig.config.abcLogic.card1().maskBankCardNumber(
                    prefixLength: 6,
                    fixStr: ' ',
                    maskCharCount: 6,
                  )),
          Image(
            image: 'ic_jt_right'.png3x,
            width: 25.w,
            height: 25.w,
          ),
        ],
      ),
    ).withOnTap(onTap: _showCardBottomSheet);
  }
}
