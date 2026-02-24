import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../utils/rich_text_widget.dart';
import '../card_transfer_logic.dart';
import '../card_transfer_state.dart';
import 'account_transfer_widget.dart';

class RemarkWidget extends StatefulWidget {
  const RemarkWidget({super.key});

  @override
  State<RemarkWidget> createState() => _RemarkWidgetState();
}

class _RemarkWidgetState extends State<RemarkWidget> {
  final CardTransferLogic logic = Get.put(CardTransferLogic());
  final CardTransferState state = Get.find<CardTransferLogic>().state;

  List transferTime = [
    '实时-立即提交',
    '普通-2小时后提交',
    '次日-次日提交',
  ];

  List tipsList = [
    '实时立即提交，不可撤销',
    '普通2小时后提交，提交前可撤销',
    '次日凌晨提交，提交前可撤销',
  ];

  String transferTimeName = '实时-立即提交';
  List titleNames = [];

  bool showTag = false;

  FocusNode focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: Colors.white,
      margin: EdgeInsets.only(top: 15.w),
      child: Column(
        children: [
          Transfer.itemCellWidget(
              title: "附言",
              hintText: '转账',
              focusNode: focusNode1,
              style: TextStyle(
                fontSize: 14.sp,
              ),
              controller: state.remarksTextController,
              // textAlign: TextAlign.right,
              onChanged: (text) {
                state.cardReq.purpose = text;
              },
          ),
          Container(
            width: 1.sw,
            height: 1.w,
            margin: EdgeInsets.only(left: 15.w),
            color: const Color(0xffE7E9EB),
          ),
          Container(
            height: 44.w,
            padding: EdgeInsets.only(left: 15.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichTextHighlighter(
                  fullText: tipsList[transferTime.indexOf(transferTimeName)],
                  highlightWords: const ["实时", "普通", "次日"],
                  highlightColor: const Color(0xffE1A14D),
                ),
                BaseText(
                  text: '修改',
                  color: Color(0xff0D703E),
                )
              ],
            ),
          ).withOnTap(onTap: () {
            FocusScope.of(context).unfocus();
            focusNode1.unfocus();
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    Container(
                      width: 1.sw,
                      height: 45.w,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6.w))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.w,
                          ),
                          BaseText(
                            text: '请选择',
                            color: Color(0xff666666),
                            fontSize: 16.sp,
                          ),
                          Icon(
                            Icons.clear,
                            size: 24.w,
                          ).withOnTap(onTap: () {
                            Get.back();
                          }),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String name = transferTime[index];
                        return Container(
                          width: 1.sw,
                          height: 55.w,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 15.w,
                              ),
                              BaseText(
                                text: name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: transferTimeName == name
                                      ? BColors.mainColor
                                      : Colors.black,
                                ),
                              ),
                              transferTimeName == name
                                  ? Image(
                                      image: 't_sel'.png3x,
                                      width: 20.w,
                                      height: 15.w,
                                    )
                                  : SizedBox(
                                      width: 20.w,
                                      height: 15.w,
                                    )
                            ],
                          ),
                        ).withOnTap(onTap: () {
                          transferTimeName = name;
                          setState(() {});
                          Get.back();
                        });
                      },
                      itemCount: transferTime.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 1.sw,
                          height: 0.5.w,
                          color: const Color(0xffEFEFEF),
                        );
                      }, //state.list.length,
                    ).withContainer(
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6.w))),
                    ),
                  ],
                ).withContainer(height: 245.w, color: Colors.white);
              },
            );
          }),
        ],
      ),
    );
  }
}
