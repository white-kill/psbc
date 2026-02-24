import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../print_logic.dart';
import '../print_state.dart';

class ShowInfoWidget extends StatefulWidget {
  const ShowInfoWidget({super.key});

  @override
  State<ShowInfoWidget> createState() => _ShowInfoWidgetState();
}

class _ShowInfoWidgetState extends State<ShowInfoWidget> {

  bool show1 = true;
  bool show2 = true;

  final PrintLogic logic = Get.find<PrintLogic>();
  final PrintState state = Get.find<PrintLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _itemWidget(
            title: '显示对方户名和账号',
            child: CupertinoSwitch(
                value: show1,
                // activeTrackColor: Color.fromARGB(255, 3, 134, 91),
                activeColor: const Color.fromARGB(255, 3, 134, 91),
                onChanged: (bool value) {
                  show1 = value;
                  if(value){
                    state.showTypeList.remove('0');
                    state.showTypeList.add('0');
                  }else {
                    state.showTypeList.remove('0');
                  }
                  setState(() {});
                }).sw()),
        Container(width: 360.w, height: 0.8.w, color: Color(0xffF4F4F6)),
        _itemWidget(
            title: '显示完整户名和帐号',
            child: CupertinoSwitch(
                value: show2,
                // activeTrackColor: Color.fromARGB(255, 3, 134, 91),
                activeColor: Color.fromARGB(255, 3, 134, 91),
                onChanged: (bool value) {
                  show2 = value;
                  if(value){
                    state.showTypeList.remove('1');
                    state.showTypeList.add('1');
                  }else {
                    state.showTypeList.remove('1');
                  }
                  setState(() {});
                }).sw()),
      ],
    ).withContainer(
      width: 1.sw,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, right: 12.w, bottom: 6.w, top: 6.w),
    );
  }

  Widget _itemWidget({String title = '', Widget? child}) {
    return Container(
      height: 45.w,
      width: 1.sw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText(text: title, color: Color(0xff333333), fontSize: 15),
          child??Container(),
        ],
      ),
    );
  }
}
