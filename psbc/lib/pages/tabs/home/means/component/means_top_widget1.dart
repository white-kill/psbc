import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/utils/stack_position.dart';

import '../means_logic.dart';
import '../means_state.dart';

class MeansTopWidget1 extends StatefulWidget {
  const MeansTopWidget1({super.key});

  @override
  State<MeansTopWidget1> createState() => _MeansTopWidget1State();
}

class _MeansTopWidget1State extends State<MeansTopWidget1> {
  final MeansLogic logic = Get.put(MeansLogic());
  final MeansState state = Get.find<MeansLogic>().state;
  
  
  List titleName = [
    '存款',
    '数字人民币',
    '投资',
  ];

  List balance = [
    '¥${AppConfig.config.abcLogic.balance()}',
    '--',
    '¥0.00',
  ];
  
  Color _lineColor(String name){
    if(name == '投资') return Color(0xff9F7E50);
    if(name == '存款') return Colors.blue;
    return Colors.red;
  }


  @override
  Widget build(BuildContext context) {
    StackPosition stackPosition =
    StackPosition(designWidth: 702, designHeight: 640, deviceWidth: 1.sw);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image(
          image: 'bg_top_zc'.png3x,
          width: 1.sw - 24.w,
        ),
        Row(
          children: [
            Container(height: 45.w)
                .expanded(onTap: () => logic.showOne.value = true),
            Container(height: 45.w)
                .expanded(onTap: () => logic.showOne.value = false)
          ],
        ),
        Positioned(
          top: 85.w,
            child: Image(
          image: 'ic_chat_zc'.png3x,
          width: 1.sw - 80.w,
          height: 120.w,
        ),),

        Positioned(
          top: 80.w,
          right: stackPosition.getX(15),
          child: Image(
            image: 'tzwz_tag'.png,
            width: 80.w,
          ),),

        Positioned(top: 120.w,child: Column(
          children: [
            BaseText(text: '总资产(元)',fontSize: 14.sp,color: Color(0xff999999),),
            SizedBox(height: 12.w,),
            BaseText(text:AppConfig.config.abcLogic.balance(),style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            )),
            SizedBox(height: 8.w,),
            Image(
              image: 'cksy_tag'.png,
              width: 72.w,
              height: 24.w,
            )
          ],
        ),),
        
        Positioned(top: 220.w,child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: titleName.map((e){
            return Column(
              children: [
                BaseText(text: e),
                BaseText(text: balance[titleName.indexOf(e)]),
                SizedBox(height: 12.w,),
                Container(
                  width:12.w,
                  height: 4.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.w)),
                    color: _lineColor(e),
                  ),
                )
              ],
            ).withContainer(
              width: (1.sw- 30.w)/3,
            );
          }).toList(),
        )),

        Positioned(bottom: 5.w,left: 12.w,
            child: Image(image: 'uswl'.png3x,
            height: 38.w,
              width: 1.sw -24.w,
            ),),
      ],
    );
  }
}
