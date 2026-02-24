import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/component/rotate_widget.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../means/means_view.dart';

class AccountMoney extends StatefulWidget {
  const AccountMoney({super.key});

  @override
  State<AccountMoney> createState() => _AccountMoneyState();
}

class _AccountMoneyState extends State<AccountMoney> {
  String eyeImg = 'ic_key_close';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'account_tag1_1'.png3x).withOnTap(onTap: (){
          Get.to(() => MeansPage());
        }),
        Positioned(
            top: 30.w,
            left: 38.5.w,
            child: Row(
              children: [
                BaseText(
                  text: '我的资产',
                  fontSize: 14,
                  color: Color(0xff66666F),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Image(
                  image: eyeImg.png3x,
                  width: 16.w,
                  height: 16.w,
                ).withContainer(
                  width: 80.w,
                  height: 30.w,
                  alignment: Alignment.centerLeft,
                  onTap: (){
                    if (eyeImg == 'ic_key_open') {
                      eyeImg = 'ic_key_close';
                    } else {
                      eyeImg = 'ic_key_open';
                    }
                    setState(() {});
                  }
                )
              ],
            )),
        Positioned(
          top: 62.w,
          left: 38.5.w,
          child: Row(
            children: [
              BaseText(
                text: eyeImg == 'ic_key_open' ? '¥${AppConfig.config.abcLogic.balance()}' : '******',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Color(0xff333333),
                ),
              ).withContainer(
                  alignment: Alignment.center,
                  height: 25.w,
                  padding:
                      EdgeInsets.only(top: eyeImg == 'ic_key_open' ? 0 : 4.w)),
              SizedBox(
                width: 6.w,
              ),
              RotatingWidget(
                image: 'ic_ref'.png3x,
                color: Colors.grey,
                disCallBack: () {
                  setState(() {});
                },
              ).withContainer(
                height: 25.w,
                alignment: Alignment.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
