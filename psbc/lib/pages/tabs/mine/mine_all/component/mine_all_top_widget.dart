import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/mine/mine_all/month_bill/month_bill_view.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../other/change_nav/change_nav_view.dart';
import '../../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../home/account/account_view.dart';
import '../../../home/bill/bill_analyze/bill_analyze_view.dart';
import '../../../home/bill/bill_view.dart';
import '../../../home/means/means_view.dart';
import '../../../home/print/print_view.dart';
import '../../../home/transfer/transfer_view.dart';

class MineAllTopWidget extends StatefulWidget {
  const MineAllTopWidget({super.key});

  @override
  State<MineAllTopWidget> createState() => _MineAllTopWidgetState();
}

class _MineAllTopWidgetState extends State<MineAllTopWidget> {

  List<String> titles = [
    '明细查询',
    '账户明细打印',
    '转账汇款',
    '我的账户',
    '我的资产',
    '收支分析',
    '月账单',
    '信用卡申请'
  ];

  void jumpPage(String name){

    if(name == '明细查询'){
      Get.to(() => BillPage());
    }
    if(name == '账户明细打印'){
      Get.to(() => PrintPage());
    }
    if(name == '转账汇款'){
      Get.to(() => TransferPage());
    }
    if(name == '我的账户'){
      Get.to(() => AccountPage());
    }
    if(name == '我的资产'){
      Get.to(() => MeansPage());
    }
    if(name == '收支分析'){
      Get.to(() => BillAnalyzePage());
    }
    if(name == '月账单'){
      Get.to(() => MonthBillPage());
    }
    if(name == '信用卡申请'){
      Get.to(() => FixedNavPage(),arguments: {
        'image':'xykth',
        'title':'线上发卡'
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
           BaseText(text: '最近使用',style: TextStyle(
            fontWeight: FontWeight.w500,
              fontFamily: "pf",
              color: Color(0xff333333),
              fontSize: 15.sp
          ),).withPadding(
            left: 12.w,
            top: 16.w,
          ),

          VerticalGridView(
            padding: EdgeInsets.only(top: 10.w,bottom: 12.w),
            widgetBuilder: (_, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: 'mine_all_taga_$index'.png3x,
                    width: 30.w,
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  BaseText(
                    text: titles[index],
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ).withOnTap(onTap: () => jumpPage(titles[index]));
            },
            itemCount: titles.length,
            crossCount: 4,
            mainHeight: 55.w,
            spacing: 10.w,
          )
        ],
      ),
    );
  }
}
