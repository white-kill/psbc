import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../home/account/account_view.dart';
import '../calendar/calendar_view.dart';

class MineEventWidget extends StatefulWidget {
  const MineEventWidget({super.key});

  @override
  State<MineEventWidget> createState() => _MineEventWidgetState();
}

class _MineEventWidgetState extends State<MineEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 75.w,
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 90.w,
            height: 68.w,
            decoration: BoxDecoration(
              image:  DecorationImage(
                image: 'mine_tag1'.png3x,
              )
            ),
            padding: EdgeInsets.only(top: 25.w,left: 15.w,),
            alignment: Alignment.centerLeft,
            child: BaseText(text: '1',fontSize: 18,color: Color(0xff333333),),
          ).withOnTap(
            onTap: () => Get.to(() => AccountPage()),
          ),

          SizedBox(
            width: 6.w,
          ),
          Container(
            width: 90.w,
            height: 68.w,
            decoration: BoxDecoration(
                image:  DecorationImage(
                  image: 'mine_tag2'.png3x,
                )
            ),
            padding: EdgeInsets.only(top: 25.w,left: 15.w,),
            alignment: Alignment.centerLeft,
            child: BaseText(text: '0',fontSize: 18,color: Color(0xff333333),),
          ).withOnTap(
            onTap: () => Get.to(() => CalendarPage()),
          ),

          SizedBox(
            width: 6.w,
          ),
          Image(
            image: 'mine_tag3'.png3x,
            width: 152.w,
            height: 68.w,
          ).withOnTap(onTap: () {
            Get.to(() => ChangeNavPage(), arguments: {
              'image': 'mine_jshx',
              'title': '我的金属画像',
              'defTitleColor': Colors.white,
            });
          }),
        ],
      ),
    );
  }
}
