import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class ShowAlterItem extends StatefulWidget {
  final List titleList;
  final String selectTitle;
  final Function callBack;

  const ShowAlterItem(
      {super.key, required this.titleList, required this.selectTitle, required this.callBack});

  @override
  State<ShowAlterItem> createState() => _ShowAlterItemState();
}

class _ShowAlterItemState extends State<ShowAlterItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: ListView.separated(
        shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                String e = widget.titleList[index];
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 18.w),
                      child: BaseText(text: e),
                    ).expanded(),
                    widget.selectTitle == e
                        ? Image(
                            image: 'card_select'.png3x,
                            width: 18.w,
                            height: 18.w,
                          )
                        : SizedBox(
                            width: 18.w,
                          ),
                  ],
                ).withContainer(width: 1.sw, height: 36.w,onTap: (){
                  widget.callBack(e);
                  Get.back();
                });
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: 1.sw,
                  margin: EdgeInsets.only(left: 6.w,right: 6.w),
                  height: 0.5.w,
                  color: Color(0xffdedede),
                );
              },
              itemCount: widget.titleList.length)
          .withContainer(margin: EdgeInsets.only(left: 12.w, right: 12.w)),
    );
  }
}
