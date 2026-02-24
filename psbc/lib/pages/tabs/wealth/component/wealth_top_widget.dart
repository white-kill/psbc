import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../config/app_config.dart';
import '../../home/means/means_view.dart';
import '../wealth_logic.dart';
import '../wealth_state.dart';

class WealthTopWidget extends StatefulWidget {
  const WealthTopWidget({super.key});

  @override
  State<WealthTopWidget> createState() => _WealthTopWidgetState();
}

class _WealthTopWidgetState extends State<WealthTopWidget> {

  final WealthLogic logic = Get.find<WealthLogic>();
  final WealthState state = Get.find<WealthLogic>().state;
  @override
  Widget build(BuildContext context) {
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return  Stack(
      children: [
        Container(
          width: 1.sw,
          height: navHeight + 258.w,
          color: Colors.white,
        ),
        Image(image: 'bg_wealth_nav'.png3x),
        Positioned(
          left: 12.w,
          top: navHeight + 18.w,
          child: Image(
            image: 'bg_wealth_top'.png3x,
            width: 1.sw - 24.w,
            height: 240.w,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            left: 30.w,
            top: navHeight + 18.w + 55.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        BaseText(
                          text: '总资产(元)',
                          fontSize: 13,
                          color: Color(0xff9F7E50),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        Obx(
                              () => Image(
                            image: logic.isOpen.value
                                ? 'cf_eye_open'.png
                                : 'cf_eye_close'.png,
                            width: 20.w,
                            height: 20.w,
                          ).withOnTap(onTap: () {
                            logic.isOpen.value = !logic.isOpen.value;
                          }),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        BaseText(
                          text: '查看详情',
                          fontSize: 13,
                          color: Color(0xff9F7E50),
                        ),
                        Image(
                          image: 'ic_jt_right'.png3x,
                          width: 20.w,
                          height: 20.w,
                          color: Color(0xff9F7E50),
                        )
                      ],
                    ).withOnTap(onTap: () =>  Get.to(() => MeansPage()))
                  ],
                )
              ],
            ).withSizedBox(
              width: 1.sw - 50.w,
            )),
        Positioned(
            left: 30.w,
            top: navHeight + 18.w + 85.w,
            child: Row(
              children: [
                Obx(
                      () => BaseText(
                    text: logic.isOpen.value
                        ? AppConfig.config.abcLogic.balance()
                        : "******",
                    fontSize: 22,
                    color: const Color(0xff653B0C),
                  ),
                ),
              ],
            ).withSizedBox(
              width: 1.sw - 50.w,
            )),
        Positioned(
            left: 30.w,
            bottom: 25.w,
            child: Container(
              width: 1.sw - 60.w,
              height: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.w)),
                color: Color(0xffFDF6E6),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 8.w,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: '理财',
                            fontSize: 12,
                            color: Color(0xff9F7E50),
                          ),
                          BaseText(
                            text: '0.01元起购',
                            fontSize: 12,
                            color: Color(0xff653B0C),
                          ),
                        ],
                      ).expanded(),
                      SizedBox(
                        width: 12.w,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: '基金',
                            fontSize: 12,
                            color: Color(0xff9F7E50),
                          ),
                          BaseText(
                            text: 'U选好基金',
                            fontSize: 12,
                            color: Color(0xff653B0C),
                          ),
                        ],
                      ).expanded(),
                      SizedBox(
                        width: 8.w,
                      ),
                    ],
                  ).expanded(),
                  Row(
                    children: [
                      SizedBox(
                        width: 8.w,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: '保险',
                            fontSize: 12,
                            color: Color(0xff9F7E50),
                          ),
                          BaseText(
                            text: '去投保',
                            fontSize: 12,
                            color: Color(0xff653B0C),
                          ),
                        ],
                      ).expanded(),
                      SizedBox(
                        width: 12.w,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: '个人养老金',
                            fontSize: 12,
                            color: Color(0xff9F7E50),
                          ),
                          BaseText(
                            text: '开启养老规划',
                            fontSize: 12,
                            color: Color(0xff653B0C),
                          ),
                        ],
                      ).expanded(),
                      SizedBox(
                        width: 8.w,
                      ),
                    ],
                  ).expanded()
                ],
              ),
            ))
      ],
    );
  }
}
