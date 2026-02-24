import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class DetailWidget3 extends StatefulWidget {
  const DetailWidget3({super.key});

  @override
  State<DetailWidget3> createState() => _DetailWidget3State();
}

class _DetailWidget3State extends State<DetailWidget3> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'zhxq_bg2'.png3x),

        Positioned(top: 55.w,child: Container(
          width: 1.sw - 30.w,
          height: 68.w,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 15.w),
                alignment: Alignment.centerRight,
                child: BaseText(text: AppConfig.config.abcLogic.memberInfo.bankList.first.openTime),
              ).expanded(),
              Container(
                padding: EdgeInsets.only(right: 15.w),
                alignment: Alignment.centerRight,
                child: BaseText(text: AppConfig.config.abcLogic.memberInfo.bankList.first.branchBelongs),
              ).expanded(),
            ],
          ),
        ))
      ],
    );
  }
}
