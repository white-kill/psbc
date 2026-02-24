import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/swiper_horizontal.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/pages/other/image_view_page.dart';

import '../../../../../utils/color_util.dart';
import '../../../../other/change_nav/change_nav_view.dart';
import '../../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../../other/search/account_print/account_print_view.dart';
import '../../print/print_view.dart';

class AccountBottomWidget extends StatefulWidget {
  const AccountBottomWidget({super.key});

  @override
  State<AccountBottomWidget> createState() => _AccountBottomWidgetState();
}

class _AccountBottomWidgetState extends State<AccountBottomWidget> {
  List<String> dataList = [
    'account_bottom_tag1',
    'account_bottom_tag2',
  ];

  void jumpPage(String name) {
    print(name);
    if (name == '0_0') {
      Get.to(() => ChangeNavPage(), arguments: {
        'image': 'szrmb',
        // 'navColor':const Color(0xffD7EDE1),
        'title': '数字人民币'
      });
    }
    if (name == '0_1') {
      Get.to(() => FixedNavPage(),
          arguments: {'image': 'yjbk', 'title': '一键绑卡'});
    }
    if (name == '0_2') {
      // Get.to(() => PrintPage());
      Get.to(() => AccountPrintPage());
    }
    if (name == '0_3') {
      Get.to(() => ImageViewPage(), arguments: {
        'image': 'cxksq',
      });
    }
    if (name == '1_0') {
      Get.to(() => FixedNavPage(),
          arguments: {'image': 'xykth', 'title': '线上发卡'});
    }
    if (name == '1_1') {
      Get.to(() => FixedNavPage(),
          arguments: {'image': 'zhutika', 'title': '无界文旅卡申请'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.w,
      width: 1.sw - 30.w,
      margin: EdgeInsets.only(top: 10.w),
      padding: EdgeInsets.only(top: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.w))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            text: '更多功能',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ).withPadding(left: 13.w),
          SizedBox(
            height: 12.w,
          ),
          SwiperHorizontal(
              itemCount: dataList.length,
              activeColor: BColors.mainColor,
              color: const Color(0xffEAEAEE),
              widgetBuilder: (_, index) {
                return _swiperItemWidget(index);
              }).withContainer(
            width: 1.sw,
            height: 90.w,
          )
        ],
      ),
    );
  }

  Widget _swiperItemWidget(int idx) {
    return Stack(
      children: [
        Image(
          image: dataList[idx].png3x,
          width: 340.w,
          height: 75.w,
        ),
        VerticalGridView(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 6.w),
          widgetBuilder: (_, index) {
            return SizedBox(
              width: 45.w,
              height: 45.w,
            ).withOnTap(onTap: () => jumpPage('${idx}_$index'));
          },
          itemCount: 4,
          crossCount: 4,
          mainHeight: 58.w,
          spacing: 12.w,
        )
      ],
    );
  }
}
