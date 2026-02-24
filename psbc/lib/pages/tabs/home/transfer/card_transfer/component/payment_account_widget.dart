import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psbc/config/app_config.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class PaymentAccountWidget extends StatefulWidget {
  const PaymentAccountWidget({super.key});

  @override
  State<PaymentAccountWidget> createState() => _PaymentAccountWidgetState();
}

class _PaymentAccountWidgetState extends State<PaymentAccountWidget> {

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
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 1.w,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            width: 1.sw - 32.w,
            color: Color(0xFFF8F8F8),
          ),
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: Row(
              children: [
                BaseText(
                  text: '付款账号',
                  fontSize: 14,
                  color: Colors.black,
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: 'tabbar_select0'.png3x,
                            width: 20.w,
                            height: 20.w,
                          ),
                          SizedBox(width: 5.w,),
                          BaseText(
                            text: AppConfig.config.abcLogic.card1().maskBankCardNumber(
                              prefixLength: 6,
                              fixStr: ' ',
                              maskCharCount: 6,
                            ),
                            fontSize: 15,
                            color: Color(0xff333333),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.w),
                      Row(
                        children: [
                          BaseText(
                            text: '可用余额',
                            fontSize: 11,
                            color: Color(0xff979797),
                          ),
                          BaseText(
                            text: ' ¥${AppConfig.config.abcLogic.balance()}',
                            fontSize: 11,
                            color: Color(0xffC9A063),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Image(
                  image: 'ic_jt_right'.png3x,
                  width: 18.w,
                  height: 18.w,
                ),
              ],
            ),
          ).withOnTap(onTap: _showCardBottomSheet),
        ],
      ),
    );
  }
}
