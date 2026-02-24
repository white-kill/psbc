import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../component/right_widget.dart';
import 'coupon_logic.dart';
import 'coupon_state.dart';

class CouponPage extends BaseStateless {
  CouponPage({Key? key}) : super(key: key,title: '卡券中心');

  final CouponLogic logic = Get.put(CouponLogic());
  final CouponState state = Get.find<CouponLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: state.titles.map((e){
            return Obx(() => Column(
              children: [
                SizedBox(height: 5.w,),
                BaseText(text: e,style: TextStyle(
                    fontSize: 15,
                  fontWeight: e == logic.selectName.value
                      ?FontWeight.bold:FontWeight.normal
                ),),
                SizedBox(height: 2.w,),
                Container(width: 45.w,height: 2,color:e == logic.selectName.value
                    ? BColors.mainColor:Colors.white,),
                SizedBox(height: 5.w,),
              ],
            ).withOnTap(onTap: (){
              logic.selectName.value = e;
            }));
          }).toList(),
        ).withContainer(
          color: Colors.white,
        ),


        ListView(
          children: [
            Image(image: 'mine_kqzx'.png3x),
          ],
        ).expanded()
      ],
    );
  }
}
