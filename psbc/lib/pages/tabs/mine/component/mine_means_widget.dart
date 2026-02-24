import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wb_base_widget/component/rotate_widget.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';
import 'package:psbc/pages/other/change_nav/change_nav_view.dart';
import 'package:psbc/utils/common_right_button.dart';


import '../../../../config/app_config.dart';
import '../../home/means/means_view.dart';
import '../mine_logic.dart';
import '../mine_state.dart';

class MineMeansWidget extends StatefulWidget {
  const MineMeansWidget({super.key});

  @override
  State<MineMeansWidget> createState() => _MineMeansWidgetState();
}

class _MineMeansWidgetState extends State<MineMeansWidget> {

  Widget replaceAsterisksWithImages(String text) {
    final parts = text.split('*');
    final spans = <InlineSpan>[];

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i], style:TextStyle(
        fontSize: 14.sp,
      ),));
      if (i != parts.length - 1) {
        spans.add(WidgetSpan(
          child: Image(image: 'ic_mine_xin'.png3x,width: 10.w,height: 10.w,).withPadding(
              left: 2.w,bottom: 4.w
          ),
          alignment: PlaceholderAlignment.middle,
        ));
      }
    }

    return Text.rich(
      maxLines: 10,
      textAlign: TextAlign.right,
      TextSpan(children: spans),
    );
  }

  Widget replaceAsterisksWithImagesSmall(String text) {
    final parts = text.split('*');
    final spans = <InlineSpan>[];

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i], style:TextStyle(
        fontSize: 10.sp,
      ),));
      if (i != parts.length - 1) {
        spans.add(WidgetSpan(
          child: Image(image: 'ic_mine_xin'.png3x,width: 6.w,height: 6.w,).withPadding(
              left: 2.w,bottom: 4.w
          ),
          alignment: PlaceholderAlignment.middle,
        ));
      }
    }

    return Text.rich(
      maxLines: 10,
      textAlign: TextAlign.right,
      TextSpan(children: spans),
    );
  }

  final MineLogic logic = Get.find<MineLogic>();
  final MineState state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'mine_wdzc'.png3x).withContainer(
            padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          bottom: 10.w,
        )),
        Positioned(right: 15.w,top: 50.w.w,child: Container(
          width: 1.sw,
          height: 80.w,
        ).withOnTap(onTap: ()=> Get.to(() => MeansPage()))),

        Positioned(right: 15.w,top: 0.w,child: Container(
          width: 100.w,
          height: 50.w,
        ).withOnTap(onTap: () {
          Get.to(() => ChangeNavPage(),
              arguments: {'image': 'fxpg', 'title': '风险评估','rightWidget': CommonRightButton.build([
                RightButtonConfig(type: RightButtonType.customerService),
                RightButtonConfig(type: RightButtonType.home),
              ]),});
        })),

        Positioned(right: 0.w,top: 132.w,child: Container(
          width: 1.sw,
          height: 42.w,
        ).withOnTap(onTap: () {
          Get.to(() => FixedNavPage(),
              arguments: {'image': 'yhwj', 'title': '邮惠万家', 'rightWidget': CommonRightButton.build([]),});
        })),

        Positioned(
          left: 100.w,top: 16.w,
          child: Container(
          child: Obx(() => Row(
            children: [
              SizedBox(width: 12.w,),
              Image(
                image: logic.eyeImg.value.png3x,
                width: 18.w,
                height: 18.w,
              ).withContainer(
                  alignment: Alignment.centerLeft,
                  onTap: (){
                    if (logic.eyeImg.value == 'ic_key_open') {
                      logic.eyeImg.value = 'ic_key_close';
                    } else {
                      logic.eyeImg.value = 'ic_key_open';
                    }
                  }
              ),
              SizedBox(width: 12.w,),
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
          )),
        ),),
        Positioned(
          left: 14.w + 15.w,
          top: 94.w,
          child:Obx(() => logic.eyeImg.value == 'ic_key_open' ? BaseText(
            text: "¥${AppConfig.config.abcLogic.balance()}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ):replaceAsterisksWithImages('******')),
        ),

        Positioned(
          right: 10.w + 15.w,
          top: 65.w,
          child:BaseText(
            text: "昨日收益（元）",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff888888),
            ),
          ),
        ),

        Positioned(
          right: 14.w + 15.w,
          top: 97.w,
          child:Obx(() => logic.eyeImg.value == 'ic_key_open' ? BaseText(
            text: "¥0.00",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ):replaceAsterisksWithImagesSmall('******')),
        )
      ],
    );
  }
}
