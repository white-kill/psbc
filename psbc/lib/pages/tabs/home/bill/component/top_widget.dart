import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/config/model/bill_model.dart';
import 'package:psbc/pages/component/sheet_widget/sheet_bottom.dart';
import 'package:psbc/pages/tabs/home/print/print_view.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../component/alter_card_bottom.dart';
import '../bill_logic.dart';
import '../bill_state.dart';
import '../search_history/search_history_view.dart';
import 'filter_bill_tag_widget.dart';
import 'filter_bill_time_widget.dart';

class BillTopWidget extends StatefulWidget {
  const BillTopWidget({super.key});

  @override
  State<BillTopWidget> createState() => _BillTopWidgetState();
}

class _BillTopWidgetState extends State<BillTopWidget> {

  final BillLogic logic = Get.put(BillLogic());
  final BillState state = Get.find<BillLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        children: [
          SizedBox(height: 6.w),
          GetBuilder(
            builder: (BillLogic c) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GetBuilder(builder: (BillLogic c){
                        String title = '';
                        if(c.state.isMonth){
                          // 优先使用滚动监听到的当前可见时间
                          if(c.state.dateTime.isNotEmpty && !c.state.isAtTop){
                            title = c.state.dateTime.replaceAll('-', '.');
                          } else {
                            title = c.state.mothTime.replaceAll('-', '.');
                          }
                        }else {
                          if(c.state.timeTitle == ''){
                            title = '${c.state.beginTime.replaceAll('-', '.')} - ${c.state.endTime.replaceAll('-', '.')}';
                          }else{
                            title = c.state.timeTitle;
                          }
                        }
                        return _tagWidget(title,onTap: (){
                          SheetBottom.show(
                            title: '时间选择',
                            rightWidget: Image(
                              image: 'close'.png3x,
                              width: 16.w,
                              height: 16.w,
                            ).withOnTap(onTap: () => Get.back()),
                            child: const FilterBillTimeWidget(),
                          );
                        });
                      },id: 'updateTime',),
                      SizedBox(
                        width: 15.w,
                      ),
                      _tagWidget( //'绿卡通${AppConfig.config.abcLogic.cardFour()}',
               "全部账户",
                          onTap: (){
                        SheetBottom.show(
                          title: '请选择',
                          rightWidget: Image(
                            image: 'close'.png3x,
                            width: 16.w,
                            height: 16.w,
                          ).withOnTap(onTap: () => Get.back()),
                          child: const AlterCardBottom(),
                        );
                      }),
                      SizedBox(
                        width: 15.w,
                      ),

                      _tagWidget('筛选',onTap: (){
                        SheetBottom.show(
                          title: '请选择筛选条件',
                          rightWidget: Image(
                            image: 'close'.png3x,
                            width: 16.w,
                            height: 16.w,
                          ).withOnTap(onTap: () => Get.back()),
                          child: const FilterBillTagWidget(),
                        );
                      }),
                    ],
                  ),

                  Image(image: 'detail-icon'.png,width: 28.w,height: 28.w,).withOnTap(
                      onTap: (){
                        Get.to(() => PrintPage());
                      }
                  )

                ],
              );
            },
            id: 'upDateTopWidget',
          ),
          SizedBox(height: 6.w),
          Container(
            width: 1.sw,
            height: 30.w,
            margin: EdgeInsets.only(right: 15.w,top: 12.w,bottom: 6.w),
            decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.all(Radius.circular(15.w))),
            child: Row(
              children: [
                Image(
                  image: 'ic_search_left'.png3x,
                  width: 15.w,
                  height: 15.w,
                ).withContainer(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                ),
                TextFieldWidget(
                  hintText:'请输入收/付款人姓名/卡号/手机号/附言搜索',
                  enabled: false,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                  controller: state.searchController,
                ).expanded(onTap: (){
                  Get.to(() => SearchHistoryPage());
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagWidget(String content, {Function? onTap}) {
    return Row(
      children: [
        Row(
          children: [
            BaseText(
              text: content,
              fontSize: 12.sp,
              color:  Color(0xff333333),
            ),
          ],
        ),
        SizedBox(
          width: 4.w,
        ),
        Image(
          image: 'arr_dow'.png3x,
          width: 6.w,
          height: 6.w,
          color: Colors.black,
        ),
      ],
    ).withOnTap(onTap: onTap);
  }

}
