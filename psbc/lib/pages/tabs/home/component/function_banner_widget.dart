import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/wb_base_widget.dart';

import '../../../other/change_nav/change_nav_view.dart';
import '../../../other/fixed_nav/fixed_nav_view.dart';
import '../../mine/mine_all/mine_all_view.dart';
import '../bill/bill_analyze/analyze_detail/analyze_detail_view.dart';
import '../bill/bill_view.dart';
import '../scan_widget/scan_widget_view.dart';
import '../transfer/thzayc/thzayc_view.dart';
import 'hdzq/hdzq_view.dart';

class FunctionBannerWidget extends StatefulWidget {
  const FunctionBannerWidget({super.key});

  @override
  State<FunctionBannerWidget> createState() => _FunctionBannerWidgetState();
}

class _FunctionBannerWidgetState extends State<FunctionBannerWidget> {
  List<String> dataList = [
    'home_tag1',
    'home_tag2',
  ];

  void jumpPage(String tag) {
    if(tag == '0_0'){
      Get.to(() => BillPage());
    }
    if(tag == '0_1'){
      Get.to(() => ChangeNavPage(),arguments: {
        'image':'bg_hoem_lc',
        'title':'理财'
      });
    }
    if(tag == '0_2'){
      Get.to(() => FixedNavPage(),arguments: {
        'image':'xykth',
        'title':'线上发卡'
      });
    }
    if(tag == '0_3'){
      Get.to(() => FixedNavPage(),arguments: {
        'image':'ck',
        'title':'存款'
      });
    }

    if(tag == '0_4'){
      Get.to(() => FixedNavPage(),arguments: {
        'image':'yjbk',
        'title':'一键绑卡'
      });
    }
    if(tag == '0_5'){
      Get.to(() => ChangeNavPage(),arguments: {
        'image':'youxiang',
        'title':'邮享贷'
      });
    }

    if(tag == '0_6'){
      Get.to(() => HdzqPage());
    }
    if(tag == '0_7'){
      Get.to(() => FixedNavPage(),arguments: {
        'image':'bx',
        'title':'保险'
      });
    }


    if(tag == '0_8'){
      Get.to(() => FixedNavPage(),arguments: {
        'image':'home_jijin',
        'title':'基金'
      });
    }
    if(tag == '0_9'){
      Get.to(() =>  MineAllPage());
    }

    if(tag == '1_0'){
      Get.to(() => ChangeNavPage(),arguments: {
        'image':'szrmb',
        'title':'数字人民币'
      });
    }
    if(tag == '1_1'){
      Get.to(() => ChangeNavPage(),arguments: {
        'image':'xwlylzq',
        'title':'U享未来养老专区'
      });
    }
    if(tag == '1_5'){
      Get.to(() => ChangeNavPage(),arguments: {
        'image':'shjf',
        'title':'生活缴费'
      });
    }
    if(tag == '1_6'){
      Get.to(() => ThzaycPage());
    }
    if(tag == '1_7'){
      Get.to(() => FixedNavPage(),arguments: {
        'image':'gjs_1',
        'title':'贵金属'
      });
    }
    if(tag == '1_8'){
      Get.to(() => ScanWidgetPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156.w,
      width: 1.sw,
      color: Colors.white,
      child: SwiperHorizontal(
          itemCount: dataList.length,
          activeColor: BColors.mainColor,
          color: const Color(0xffEAEAEE),
          widgetBuilder: (_, index) {
            return _swiperItemWidget(index);
          }),
    );
  }

  Widget _swiperItemWidget(int idx) {
    return Stack(
      children: [
        Image(image: dataList[idx].png3x,width: 1.sw,height: 134.w,),
        VerticalGridView(
          padding: EdgeInsets.only(left: 16.w,right: 16.w),
          widgetBuilder: (_, index) {
            return SizedBox(
              width: 45.w,
              height: 45.w,
            ).withOnTap(onTap: () => jumpPage('${idx}_$index'));
          },
          itemCount: 10,
          crossCount: 5,
          mainHeight: 58.w,
          spacing: 12.w,
        )
      ],
    );
  }
}
