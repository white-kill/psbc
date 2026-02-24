import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/scan_widget/scan_widget_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../other/fixed_nav/fixed_nav_view.dart';
import '../../transfer/transfer_myself/transfer_myself_view.dart';


class RightPointWidget extends StatefulWidget {
  final double? width;
  final double? left;
  final double? dx;
  final double? dy;
  final Function callBack;

  const RightPointWidget({
    super.key,
    this.width,
    this.left,
    this.dx,
    this.dy,
    required this.callBack,
  });

  @override
  State<RightPointWidget> createState() => _RightPointWidgetState();
}

class _RightPointWidgetState extends State<RightPointWidget> {
  Color color1 = Colors.white;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => scalePoint(context),
          child:  Image(image: 'bill_more'.png3x,width: 24.w,height: 24.w,),
        ),
      );
    });
  }

  List titles = [
    '在线客服',
    '返回首页',
    '账户明细打印',
    '月账单',
    '月度结余',
    '年账单',
  ];

  void scalePoint(BuildContext context) {
    SmartDialog.showAttach(
      targetContext: context,
      targetBuilder: (targetOffset, targetSize) {
        return Offset(targetOffset.dx - (widget.dx ?? 0),
            targetOffset.dy - (widget.dy ?? 0));
      },
      alignment: Alignment.bottomCenter,
      animationType: SmartAnimationType.scale,
      maskColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          width: widget.width ?? 100.w,
          child: Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: widget.left ?? 50.w),
              child: Container(
                width: 14.w,
                height: 14.w,
                color: Colors.white,
                transform: Matrix4.rotationZ(pi / 4),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 7),
              width: widget.width ?? 240.w,
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,  // 阴影向外扩散的范围
                    blurRadius: 10,   // 阴影的模糊程度
                    offset: Offset(0, 0), // 偏移量设为 0，阴影将均匀分布在四周
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                    children:titles.map((e){
                      int index = titles.indexOf(e);
                      return Row(
                        spacing: 3.w,
                        children: [
                          Image(
                            image: 'bill_s${index+1}'.png,
                            width: 20.w,
                            height: 20.w,
                          ).withPadding(
                            left: 2.w,
                            right: 8.w,
                          ),
                          BaseText(
                            text: e,
                            color: Colors.black,
                          )
                        ],
                      ).withContainer(
                        onTap: () {
                          SmartDialog.dismiss();
                          widget.callBack(e);
                        },
                        height: 42.w,
                        alignment: Alignment.centerLeft,
                      );
                    }).toList(),
                  ).withPadding(left: 12.w,),
            ),
          ]),
        );
      },
    );
  }
}
