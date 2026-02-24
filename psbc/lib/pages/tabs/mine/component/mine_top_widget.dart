import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/tabs/mine/benefits_center/benefits_center_view.dart';
import 'package:psbc/pages/tabs/mine/info/info_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class MineTopWidget extends StatefulWidget {
  const MineTopWidget({super.key});

  @override
  State<MineTopWidget> createState() => _MineTopWidgetState();
}

class _MineTopWidgetState extends State<MineTopWidget> {
  String valueStr(int index) {
    if (index == 0) {
      return AppConfig.config.abcLogic.memberInfo.appAccount;
    }
    if (index == 1) {
      DateTime now = DateTime.now();
      DateTime yesterday = now.subtract(const Duration(days: 1));
      return DateFormat('yyyy-MM-dd hh:mm:ss').format(yesterday);
    }
    return '';
  }

  String hideLastName(String name) {
    if (name.isEmpty) return name;

    name = name.trim();
    if (name.length == 2) {
      return '${name[0]}*';
    }
    if (name.length > 2) {
      return '${name[0]}${'*' * (name.length - 1)}';
    }

    return name;
  }

   String maskName(String? name) {
    // 处理空值/空字符串
    if (name == null || name.trim().isEmpty) {
      return "";
    }
    String realName = name.trim();
    int length = realName.length;

    // 单字名：直接返回（无脱敏必要）
    if (length == 1) {
      return realName;
    }
    // 两字名：第二个字替换为*
    else if (length == 2) {
      return "${realName.substring(0, 1)}*";
    }
    // 超两字名：首尾保留，中间全替换为*
    else {
      String firstChar = realName.substring(0, 1);
      String lastChar = realName.substring(length - 1);
      // 计算中间需要替换的*数量
      String middleStars = "*" * (length - 2);
      return "$firstChar$middleStars$lastChar";
    }
  }

  String getTimeOfDayDetail() {
    DateTime now = DateTime.now();
    int hour = now.hour;
   if (hour >= 5 && hour < 12) {
      return '上午';
    } else if (hour >= 12 && hour < 18) {
      return '下午';
    } else {
      return '晚上';
    }
  }

  // 跳转到权益中心
  void _navigateToBenefitsCenter() {
    int level = 6; // 默认6级
    
    Get.to(() => BenefitsCenterPage(), arguments: {
      'level': level,
    });
  }

  @override
  Widget build(BuildContext context) {
    final navHeight = MediaQuery.of(context).padding.top + 44.w;
    return Container(
      width: 1.sw,
      height: 200.w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffF0F6F4),
            // Color(0xffFDFDFD),
            Color(0xFFF5F5F5)
          ],
        ),
      ),
      padding: EdgeInsets.only(top: navHeight + 14.w, left: 17.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: 'mine_head_img'.png3x,
                width: 57.w,
                height: 57.w,
              ).withOnTap(onTap: (){
                Get.to(() => InfoPage());
              }),
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    text: '${getTimeOfDayDetail()}好，${maskName(AppConfig.config.abcLogic.memberInfo.realName)}',
                    color: Color(0xff2E2E30),
                    fontSize: 18.sp,
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Swiper(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      List nameList = [
                        '预留信息:',
                        '上次登录时间:',
                      ];
                      return Row(
                        children: [
                          BaseText(
                            text: nameList[index],
                            color: Color(0xff96979A),
                            fontSize: 11,
                          ),
                          BaseText(
                            text: valueStr(index),
                            fontSize: 11,
                          )
                        ],
                      );
                    },
                    itemCount: 2,
                    autoplay: true,
                  ).withContainer(
                    width: 182.w,
                    height: 20.w,
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 6.w,
                  ),
                  Image(
                    image: 'xinji'.png3x,
                    width: 72.w,
                    height: 20.w,
                  ).withOnTap(onTap: () {
                    _navigateToBenefitsCenter();
                  })
                ],
              )
            ],
          ),
          Swiper(
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              List<String> imageList = [
                'mine_top_tag0',
                'mine_top_tag1',
              ];
              return Column(
                children: [
                  Image(
                    image: imageList[index].png3x,
                  )
                ],
              );
            },
            itemCount: 2,
            autoplay: true,
          ).withContainer(
            width: 100.w,
            height: 90.w,
          ),
        ],
      ),
    );
  }
}
