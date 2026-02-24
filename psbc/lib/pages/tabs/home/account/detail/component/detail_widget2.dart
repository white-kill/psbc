import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../other/change_nav/change_nav_view.dart';
import '../../../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../bill/bill_view.dart';
import '../../../transfer/transfer_view.dart';

class DetailWidget2 extends StatefulWidget {
  const DetailWidget2({super.key});

  @override
  State<DetailWidget2> createState() => _DetailWidget2State();
}

class _DetailWidget2State extends State<DetailWidget2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //gmlc
        Image(image: 'zhxq_bg1'.png3x),
        Positioned(top: 28.w, left: 15.w, child: Container(
          width: 1.sw - 72.w,
          height: 45.w,
          child: Row(
            children: [
              Container(
                child: BaseText(text: '¥' + AppConfig.config.abcLogic.balance(),
                    fontSize: 17,
                    color: Color(0xff2E2E30),),
              ).expanded(),
              SizedBox(width: 30.w,),
              Container(
                child: BaseText(text:'¥' + AppConfig.config.abcLogic.balance(),
                    fontSize: 17,
                    color: Color(0xff2E2E30),),
              ).expanded(),
            ],
          ),
        )),

        Positioned(top: 75.w, child: Container(
          width: 1.sw - 42.w,
          height: 43.w,
          child: Row(
            children: [
              Container().expanded(
                onTap: () => Get.to(() => BillPage())
              ),
              Container().expanded(
                  onTap: () => Get.to(() => TransferPage())
              ),
              Container().expanded(
                  onTap: (){
                    Get.to(() => ChangeNavPage(),arguments: {
                      'image':'gmlc',
                      'title':'购买理财'
                    });
                  }
              ),
              Container().expanded(
                  onTap: (){
                    Get.to(() => FixedNavPage(),arguments: {
                      'image':'home_jijin',
                      'title':'基金'
                    });
                  }
              ),
            ],
          ),
        ))
      ],
    );
  }
}
