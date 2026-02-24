import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class AlterCardBottom extends StatefulWidget {
  const AlterCardBottom({super.key});

  @override
  State<AlterCardBottom> createState() => _AlterCardBottomState();
}

class _AlterCardBottomState extends State<AlterCardBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 260.w,
      child: Column(
        children: [
          SizedBox(height: 18.w,),
          Row(
            children: [
              Image(image: 'bank_all'.png3x,width: 45.w,height: 22.w,),
              BaseText(text: '全部账户'),
            ],
          ),
          SizedBox(height: 18.w,),
          Container(
            width: 1.sw,
            height: 0.5.w,
            margin: EdgeInsets.only(left: 12.w,right: 12.w),
            color: Color.fromARGB(255, 235, 235, 235),
          ),
          SizedBox(height: 18.w,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Row(
               children: [
                 Image(image: 'yz'.png3x,width: 45.w,height: 28.w,),

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     BaseText(text: '1213 ****** 8765'),
                     SizedBox(height: 8.w,),
                     BaseText(text: '中国邮政银行',color: Color(0xff666666),)
                   ],
                 ),
               ],
             ),

              Row(
                children: [
                  Image(image: 'card_yl'.png3x,width: 55.w,height: 26.w,),
                  Image(image: 'card_select'.png3x,width: 18.w,height: 18.w,),
                ],
              )
            ],
          ),
          SizedBox(height: 18.w,),
          Container(
            width: 1.sw,
            height: 0.5.w,
            margin: EdgeInsets.only(left: 12.w,right: 12.w),
            color: Color.fromARGB(255, 235, 235, 235),
          ),
        ],
      ).withContainer(
        margin: EdgeInsets.only(left: 12.w,right: 12.w)
      ),
    );
  }
}
