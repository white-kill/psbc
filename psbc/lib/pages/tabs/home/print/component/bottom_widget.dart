import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/print/apply_record/apply_record_view.dart';
import 'package:psbc/utils/abc_button.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/pages/other/fixed_nav/fixed_nav_view.dart';

import '../../../../component/sheet_widget/sheet_bottom.dart';
import '../print_logic.dart';
import '../print_state.dart';
import 'email_tips.dart';
import 'input_pas.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  bool tag1 = false;
  final PrintLogic logic = Get.find<PrintLogic>();
  
  void _showDetailBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: Image(
            image: 'print_bottom_2'.png3x,
            width: 1.sw,
            fit: BoxFit.fitWidth,
          ),
        );
      },
    );
  }
  
  void _showTipsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: Image(
            image: 'print_bottom_3'.png3x,
            width: 1.sw,
            fit: BoxFit.fitWidth,
          ),
        );
      },
    );
  }
  final PrintState state = Get.find<PrintLogic>().state;

  List tagList = [
    '样例预览',
    '',
    '申请记录',
    '',
    '常见问题',
  ];

  List typeName = [
    '发送邮箱',
    '本地下载',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 50.w,
          color: Colors.white,
          padding: EdgeInsets.only(left: 17.w, right: 17.w),
          child: Row(
            spacing: 26.w,
            children: [
              BaseText(text: '获取方式'),
              Row(
                spacing: 12.w,
                children: typeName.map((e) {
                  return Row(
                    spacing: 6.w,
                    children: [
                      Image(
                        image: state.selType == e ? 'p_se'.png3x : 'p_un'.png3x,
                        width: 20.w,
                        height: 20.w,
                      ),
                      BaseText(text: e),
                    ],
                  ).withOnTap(onTap: () {
                    if (state.selType == '本地下载') {
                      state.reqPrint.email = '';
                    }
                    state.selType = e;
                    setState(() {});
                  });
                }).toList(),
              )
            ],
          ),
        ),
        RichText(
          maxLines: 2,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                  text: '接收邮箱建议使用国内网易邮箱(163,126等)，腾讯QQ邮箱，'
                      '中移139邮箱，电信189邮箱。境外邮箱可...',
                  style: TextStyle(fontSize: 14, color: Color(0xff919195))),
              TextSpan(
                text: '查看详情',
                style: TextStyle(
                  color: BColors.mainColor,
                  fontSize: 13,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _showDetailBottomSheet();
                  },
              ),
            ],
          ),
        ).withContainer(
          color: const Color(0xFFF5F5F5),
          padding: EdgeInsets.all(17.w),
        ),
        Container(
          width: 1.sw,
          color: Colors.white,
          padding: EdgeInsets.only(left: 17.w, right: 17.w),
          child: Column(
            children: [
              // Container(
              //   width: 1.sw,
              //   height: 0.8,
              //   color: Color(0xffdedede),
              // ),
              state.selType == '本地下载'
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        const BaseText(text: '接收邮箱'),
                        SizedBox(
                          width: 28.w,
                        ),
                        TextFieldWidget(
                          hintText: '请输入正确的邮箱格式',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) {
                            state.reqPrint.email = v;
                          },
                        ).expanded(),
                      ],
                    ).withContainer(
                      width: 1.sw,
                      padding: EdgeInsets.only(
                        top: 6.w,
                        bottom: 6.w,
                      )),
              // Container(
              //   width: 1.sw,
              //   height: 0.8,
              //   color: Color(0xffdedede),
              // ),
              SizedBox(
                height: 10.w,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: tag1 ? 'a_check'.png3x : 'a_un_check'.png3x,
                    width: 16.w,
                    height: 16.w,
                  ).withContainer(
                      padding: EdgeInsets.only(right: 6.w, top: 2.w),
                      onTap: () {
                        tag1 = !tag1;
                        setState(() {});
                      }),
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                            text: '我已阅读',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff919195))),
                        TextSpan(
                          text: '线上办理个人账户明细打印温馨提示',
                          style: TextStyle(
                            color: BColors.mainColor,
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _showTipsBottomSheet();
                            },
                        ),
                        TextSpan(
                            text: '我并同意相关内容',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff919195))),
                      ],
                    ),
                  ).withSizedBox(width: 310.w),
                ],
              ),
              SizedBox(
                height: 12.w,
              ),

              AbcButton(
                title: '提交',
                width: 345.w,
                height: 45.w,
                radius: 4.w,
                onTap: () {
                  state.reqPrint.showType = state.showTypeList.join(',');
                  if (state.selType == '发送邮箱') {
                    if (!logic.isValidEmail(state.reqPrint.email)) {
                      '请输入正确的邮箱'.showToast;
                      return;
                    }
                  }
                  if (!tag1) {
                    '请输阅读并同意相关内容'.showToast;
                    return;
                  }
                  if (state.selType == '本地下载') {
                    SheetBottom.show(
                      title: '交易密码认证',
                      rightWidget: Image(
                        image: 'close'.png3x,
                        width: 16.w,
                        height: 16.w,
                      ).withOnTap(onTap: () => Get.back()),
                      child: InputPas(
                        reqPrint: state.reqPrint,
                      ),
                    );
                  } else {
                    SheetBottom.show(
                      title: '温馨提示',
                      rightWidget: Image(
                        image: 'close'.png3x,
                        width: 16.w,
                        height: 16.w,
                      ).withOnTap(onTap: () => Get.back()),
                      child: EmailTips(
                        reqPrint: state.reqPrint,
                      ),
                    );
                  }
                  print(state.reqPrint.toJson());
                },
              ),
              SizedBox(
                height: 30.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tagList.map((e) {
                  if (e == '') {
                    return Container(
                      width: 1.w,
                      height: 15.w,
                      color: BColors.mainColor,
                      margin: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                    );
                  }
                  return BaseText(
                    text: e,
                    color: BColors.mainColor,
                  ).withOnTap(onTap: () {
                    if (e == '申请记录') {
                      Get.to(() => ApplyRecordPage());
                    } else if (e == '常见问题') {
                      Get.to(() => FixedNavPage(), arguments: {
                        'image': 'cjwt_bottom',
                        'title': '常见问题',
                      });
                    }else {

                      Get.to(() => FixedNavPage(), arguments: {
                        'image': 'ylyl_bottom',
                        'title': '样例预览',
                      });
                    }
                  });
                }).toList(),
              ),
              SizedBox(
                height: 50.w,
              ),
            ],
          ),
        )
      ],
    );
  }
}
