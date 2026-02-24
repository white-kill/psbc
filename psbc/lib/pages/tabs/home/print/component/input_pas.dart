import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/abc_button.dart';
import '../../../../component/sheet_widget/sheet_bottom.dart';
import '../req_print.dart';
import 'input_code.dart';

class InputPas extends StatefulWidget {
  final ReqPrint? reqPrint;
  final Function? onTap;

  const InputPas({super.key,this.reqPrint, this.onTap});

  @override
  State<InputPas> createState() => _InputPasState();
}

class _InputPasState extends State<InputPas> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 180.w,
      child: Column(
        children: [
          Row(
            children: [
              BaseText(text: '交易密码'),
              TextFieldWidget(
                hintText: '请输入手机银行交易密码',
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                onChanged: (v) {
                  value = v;
                  setState(() {});
                },
              ).withContainer(
                width: 240.w,
                height: 36.w,
                padding: EdgeInsets.only(left: 32.w),
              )
            ],
          ).withPadding(
            left: 12.w,
            right: 12.w,
            top: 15.w,
          ),
          SizedBox(
            height: 16.w,
          ),
          BaseText(
            text: '忘记密码',
            maxLines: 3,
            color: BColors.mainColor,
          ).withContainer(
              width: 1.sw,
              padding: EdgeInsets.only(right: 12.w),
              alignment: Alignment.centerRight),
          SizedBox(
            height: 12.w,
          ),
          SizedBox(
            height: 24.w,
          ),
          AbcButton(
            title: '下一步',
            width: 345.w,
            height: 45.w,
            bgColor: value.length < 6 ? Color(0xffD1E3DA) : BColors.mainColor,
            radius: 4.w,
            onTap: () {
              if (value.length < 6) return;
              if(widget.onTap == null){
                Get.back();
                SheetBottom.show(
                  title: '交易密码认证',
                  rightWidget: Image(
                    image: 'close'.png3x,
                    width: 16.w,
                    height: 16.w,
                  ).withOnTap(onTap: () => Get.back()),
                  child: InputCode(
                    reqPrint: widget.reqPrint!,
                  ),
                );
              }else {
                widget.onTap?.call();
              }
            },
          ),
        ],
      ),
    );
  }
}
