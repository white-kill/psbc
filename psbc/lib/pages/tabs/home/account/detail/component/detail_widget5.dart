import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wb_base_widget/component/alter_widget.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/swiper_horizontal.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../utils/color_util.dart';
import '../../../../../other/fixed_nav/fixed_nav_view.dart';
import '../../../../../other/search/account_print/account_print_view.dart';
import '../../../print/print_view.dart';
import '../../../transfer/thzayc/thzayc_view.dart';

class DetailWidget5 extends StatefulWidget {
  const DetailWidget5({super.key});

  @override
  State<DetailWidget5> createState() => _DetailWidget5State();
}

class _DetailWidget5State extends State<DetailWidget5> {
  final GlobalKey _targetKey = GlobalKey();

  List<String> dataList = [
    'zhxq_bg4_1',
    'zhxq_bg4_2',
  ];

  void jumpPage(String name) {
    print(name);
    switch (name) {
      case '0_0':
        _getPosition();
        break;
      case '0_1':
        Get.to(() => AccountPrintPage());
        break;
      case '0_2':
        Get.to(() => FixedNavPage(),arguments: {
          'image':'dqck',
          'title':'定期存款'
        });
        break;
      case '0_3':
        Get.to(() => ThzaycPage());
        break;
    }
  }

  void _getPosition() {
    final RenderBox? renderBox =
        _targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final position = renderBox.localToGlobal(Offset.zero);
      AlterWidget.alterWidget(
          useAnimation: false,
          builder: (context) {
            return Stack(
              children: [
                SizedBox(
                  width: 1.sw,
                  height: 1.sh,
                ),
                Positioned(
                  left: position.dx + 10.w,
                  top: position.dy - 200.w,
                  child: Container(
                    width: 100.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: 'tankuang'.png3x,
                    )),
                    child: Column(
                      children: [
                        Container().expanded(onTap: () async {
                          await SmartDialog.dismiss();
                          '\n请选择挂失类型\n'.dialog(
                              title: '温馨提示',
                              contentStyle: const TextStyle(
                                  fontSize: 13, color: Color(0xff666666)),
                              sureText: '永久挂失',
                              cancelText: '临时挂失');
                        }),
                        Container().expanded(onTap: () async {
                          await SmartDialog.dismiss();
                          '\n尊敬的客户，'
                                  '如您要调整账户等级请携带有效身份证件实名手机卡和银行卡，'
                                  '至我行任一营业网点办理。\n'
                              .dialog(
                                  title: '温馨提示',
                                  contentStyle: const TextStyle(
                                      fontSize: 13, color: Color(0xff666666)),
                                  showCancel: false);
                        }),
                        Container().expanded(onTap: () async {
                          await SmartDialog.dismiss();
                          '\n最后一个签约账户不允许撤销！\n'.dialog(
                              title: '温馨提示',
                              contentStyle: const TextStyle(
                                  fontSize: 13, color: Color(0xff666666)),
                              showCancel: false);
                        }),
                        Container().expanded(onTap: () async {
                          await SmartDialog.dismiss();
                          '\n您的账户存在未结利息，'
                                  '暂不支持线上销户，'
                                  '请前往我行营业网点进行后续处理！\n'
                              .dialog(
                                  title: '温馨提示',
                                  contentStyle: const TextStyle(
                                      fontSize: 13, color: Color(0xff666666)),
                                  showCancel: false);
                        }),
                        Container().expanded(onTap: () async {
                          await SmartDialog.dismiss();
                          '\n该卡未加办副卡\n'.dialog(
                              title: '温馨提示',
                              contentStyle: const TextStyle(
                                  fontSize: 13, color: Color(0xff666666)),
                              showCancel: false);
                        }),
                        SizedBox(height: 5.w),
                      ],
                    ),
                  ),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30.w,
      margin: EdgeInsets.only(top: 12.w),
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

          Container(
            key:_targetKey,
            width: 1.sw,
            height: 154.w,
            child: SwiperHorizontal(
                itemCount: dataList.length,
                activeColor: BColors.mainColor,
                color: const Color(0xffEAEAEE),
                widgetBuilder: (_, index) {
                  return _swiperItemWidget(index);
                }),
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
          width: 344.w,
          height: 134.w,
        ),
        VerticalGridView(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 6.w),
          widgetBuilder: (_, index) {
            return SizedBox(
              width: 45.w,
              height: 45.w,
            ).withOnTap(onTap: () => jumpPage('${idx}_$index'));
          },
          itemCount: 8,
          crossCount: 4,
          mainHeight: 55.w,
          spacing: 8.w,
          crossSpacing: 8.w,
        )
      ],
    );
  }
}
