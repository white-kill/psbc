import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/component/sheet_widget/sheet_bottom.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../component/alter_card_bottom.dart';
import '../dzhd_list_logic.dart';
import '../dzhd_list_state.dart';
import 'filter_record_tag_widget.dart';
import 'filter_record_time_widget.dart';

class TopWidget1 extends StatefulWidget {
  const TopWidget1({super.key});

  @override
  State<TopWidget1> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget1> {

  final Dzhd_listLogic logic = Get.find<Dzhd_listLogic>();
  final Dzhd_listState state = Get.find<Dzhd_listLogic>().state;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      margin: EdgeInsets.only(left: 15.w,right: 15,top: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.w))
      ),
      child: Column(
        children: [
          SizedBox(
            height: 12.w,
          ),
          GetBuilder(
            builder: (Dzhd_listLogic c) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      GetBuilder(builder: (Dzhd_listLogic c){
                        String title = '';
                        if(c.state.isYear){
                          title = '2020-${state.yearTime}';
                        }else {
                          if(c.state.timeTitle == ''){
                            title = '${c.state.beginTime.replaceAll('-', '.')} - ${c.state.endTime.replaceAll('-', '.')}';
                          }else{
                            title = c.state.timeTitle;
                          }
                        }
                        return _tagWidget(title,).withOnTap(onTap: (){
                          SheetBottom.show(
                            title: '选择时间',
                            leftWidget: Image(
                              image: 'ic_jt_left'.png3x,
                              width: 25.w,
                              height: 25.w,
                            ),
                            child: const FilterRecordTimeWidget1(),
                          );
                        });
                      },id: 'updateTime',),
                      SizedBox(
                        width: 15.w,
                      ),
                      _tagWidget('绿卡通${AppConfig.config.abcLogic.cardFour()}').withOnTap(onTap: () {
                        SheetBottom.show(
                          title: '请选择',
                          rightWidget: Image(
                            image: 'close'.png3x,
                            width: 18.w,
                            height: 18.w,
                          ),
                          child: const AlterCardBottom(),
                        );
                      }),
                    ],
                  ),
                  _tagWidget('筛选',)
                      .withOnTap(onTap: () {
                    SheetBottom.show(
                      title: '筛选',
                      leftWidget: Image(
                        image: 'ic_jt_left'.png3x,
                        width: 25.w,
                        height: 25.w,
                      ),
                      child: const FilterRecordTagWidget1(),
                    );
                  }),
                ],
              );
            },
            id: 'upDateTopWidget',
          ),
          SizedBox(
            height: 12.w,
          ),
        ],
      ),
    );
  }

  Widget _tagWidget(String content, {Color? color, Widget? child}) {
    return Row(
      children: [
        Row(
          children: [
            BaseText(
              text: content,
              fontSize: 13.sp,
              color: color ?? Color(0xff333333),
            ),
            child ?? SizedBox.shrink(),
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
    );
  }

}
