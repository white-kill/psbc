import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:psbc/pages/other/change_nav/change_nav_view.dart';
import 'package:psbc/pages/tabs/home/account/account_view.dart';
import 'package:psbc/pages/tabs/home/means/means_view.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../transfer/transfer_view.dart';


class TopBannerWidget extends StatefulWidget {
  const TopBannerWidget({super.key});

  @override
  State<TopBannerWidget> createState() => _TopBannerWidgetState();
}

class _TopBannerWidgetState extends State<TopBannerWidget> {
  List<String> nameList = ['我的账户', '转账汇款', '我的资产', '贷款'];

  void jumpPage(String name){
    if(name == '我的账户'){
      Get.to(() => AccountPage());
    }
    if(name == '转账汇款'){
      Get.to(() => TransferPage());
    }
    if(name == '我的资产'){
      Get.to(() => MeansPage());
    }
    if(name == '贷款'){
      Get.to(() => ChangeNavPage(),arguments: {
        'image':'dk',
        'title':'贷款'
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return VerticalGridView(
      padding: EdgeInsets.only(left: 12.w,right: 12.w,),
      widgetBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: 'home_top_tag_$index'.png3x,
              width: 45.w,
              height: 45.h,
            ),
            SizedBox(
              height: 5.w,
            ),
            BaseText(
              text: nameList[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: const Color(0xff333333),
              ),
            ),
          ],
        ).withOnTap(onTap: () => jumpPage(nameList[index]));
      },
      mainHeight:100.w,
      itemCount: 4,
    ).withContainer(
      height: 100.w,
      margin: EdgeInsets.only(left: 15.w,right: 15.w),
      decoration: BoxDecoration(
          color: const Color(0xffF4F7F6),
          borderRadius: BorderRadius.all(Radius.circular(12.w))
      ),
    );
  }
}
