import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:psbc/config/abc_config/balance_eye_widget.dart';
import 'package:psbc/utils/widget_util.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';

class HomeTabWidget extends StatefulWidget {
  const HomeTabWidget({super.key});

  @override
  State<HomeTabWidget> createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<HomeTabWidget> {
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
  }

  Widget _tagWidget(String imageName) {
    return Container(
      width: 82.w,
      height: 37.w,
      decoration: decorationImage(imageName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (currentPage == 0
                      ? _tagWidget('page_view_tag$currentPage')
                      : Container(
                          width: 82.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: '理财',
                            fontSize: 14.sp,
                            color: const Color(0xff333333),
                          ),
                        ))
                  .withOnTap(onTap: () {
                currentPage = 0;
                setState(() {});
              }),
              (currentPage == 1
                      ? _tagWidget('page_view_tag$currentPage')
                      : Container(
                          width: 82.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: '基金',
                            fontSize: 14.sp,
                            color: const Color(0xff333333),
                          ),
                        ))
                  .withOnTap(onTap: () {
                currentPage = 1;
                setState(() {});
              }),
              (currentPage == 2
                      ? _tagWidget('page_view_tag$currentPage')
                      : Container(
                          width: 82.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: '存款',
                            fontSize: 14.sp,
                            color: const Color(0xff333333),
                          ),
                        ))
                  .withOnTap(onTap: () {
                currentPage = 2;
                setState(() {});
              }),
              (currentPage == 3
                      ? _tagWidget('page_view_tag$currentPage')
                      : Container(
                          width: 82.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: '贵金属',
                            fontSize: 14.sp,
                            color: const Color(0xff333333),
                          ),
                        ))
                  .withOnTap(onTap: () {
                currentPage = 3;
                setState(() {});
              }),
            ],
          ).withPadding(all: 15.w),
          Image(
            image: 'page_view$currentPage'.png3x,
            fit: BoxFit.fitWidth,
          ).withOnTap(onTap: () {
            if(currentPage == 0){
              Get.to(() => ChangeNavPage(),
                  arguments: {'image': 'tty', 'title': '天天盈'});
            }
            if(currentPage == 1){
              Get.to(() => FixedNavPage(),arguments: {
                'image':'home_jijin',
                'title':'基金'
              });
            }
            if(currentPage == 2){
              Get.to(() => FixedNavPage(),arguments: {
                'image':'ck',
                'title':'存款'
              });
            }
            if(currentPage == 3){
              Get.to(() => FixedNavPage(),arguments: {
                'image':'gjs_1',
                'title':'贵金属'
              });
            }
          })
        ],
      ),
    );
  }
}
