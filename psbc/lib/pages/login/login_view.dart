import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/login/password/password_view.dart';
import 'package:psbc/pages/other/customer_service/customer_service_view.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'login_logic.dart';
import 'login_state.dart';

class LoginPage extends BaseStateless {
  LoginPage({Key? key}) : super(key: key, title: '');

  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;

  @override
  Color? get background => Colors.white;
  @override
  Widget? get leftItem => InkWell(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Icon(
            Icons.navigate_before,
            size: 30.h,
            color: Color(0xff333333),
          ),
        ),
        onTap: () => Get.back(),
      );

  @override
  List<Widget>? get rightAction => [
        SizedBox(
          width: 10.w,
        ),
        Image(
          width: 37.w,
          height: 37.w,
          image: 'home_right_khfw'.png3x,
        ).withOnTap(onTap: () => Get.to(() => CustomerServicePage())),
        SizedBox(
          width: 12.w,
        ),
        Image(
          width: 37.w,
          height: 37.w,
          image: 'big_font'.png3x,
        ),
        SizedBox(
          width: 16.w,
        ),
      ];

  @override
  Widget initBody(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Stack(children: [
            Positioned(
              top: ScreenUtil().statusBarHeight + 45.w,
              left: 15.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    text: '尊敬的用户，您好',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 110.w + ScreenUtil().statusBarHeight + 25.w, // 调整垂直位置
              left: 20.w, // 调整水平位置
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 4.w,
                      ),
                      Row(
                        children: [
                          BaseText(
                            text: '+86',
                            fontSize: 16,
                            color: Color(0xff333333),
                          ),
                          SizedBox(width: 4.w),
                          Image(
                            image: 'phone_arrow'.png,
                            width: 12.w,
                            height: 12.w,
                          ),
                          SizedBox(width: 8.w),
                        ],
                      ),
                      TextField(
                        controller: state.phoneTextController,
                        onChanged: (value) {
                          logic.phoneText.value = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none, // 隐藏边框
                          hintText: '请输入手机号',
                          hintStyle: TextStyle(
                            color: Color(0xff999999), // 设置提示文字颜色
                            fontSize: 16.0, // 可选：调整字体大小
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ).expanded(),
                    ],
                  ),
                  Divider(
                    color: Color(0x668C8C8C),
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 25.w,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      children: [
                        WidgetSpan(
                            child: Obx(() => Image(
                                  image: logic.tag1.value
                                      ? 'a_check'.png3x
                                      : 'a_un_check'.png3x,
                                  width: 16.w,
                                  height: 16.w,
                                ).withContainer(
                                    padding: EdgeInsets.only(right: 12.w),
                                    onTap: () {
                                      logic.tag1.value = !logic.tag1.value;
                                    })),
                            alignment: PlaceholderAlignment.middle),
                        TextSpan(
                            text: '我已同意',
                            style: TextStyle(
                              color: const Color(0xff6A6A6A),
                              fontSize: 13.sp,
                            )),
                        TextSpan(
                          text: '《中国邮政储蓄银行个人电子银行服务协议》、',
                          style: TextStyle(
                            color: BColors.mainColor,
                            fontSize: 13.sp,
                          ),
                        ),
                        TextSpan(
                          text: '《中国邮政储蓄银行电子银行隐私政策》',
                          style: TextStyle(
                            color: BColors.mainColor,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.w),
                    child: Container(
                      width: double.infinity, // 使按钮宽度和下划线一样长
                      height: 44.w,
                      child: Obx(() {
                        bool isEnabled = logic.phoneText.value.length == 11;
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                isEnabled
                                    ? BColors.mainColor
                                    : Color(0xffCBE5DA)),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          onPressed: () {
                            // 处理登录点击事件
                            if (state.phoneTextController.text.length == 11) {
                              Get.to(() => PasswordPage(), arguments: {
                                'phone': state.phoneTextController.text
                              });
                            }
                          },
                          child: Text(
                            '注册/登录',
                            style: TextStyle(fontSize: 17.sp),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25.w)),
                  SizedBox(
                      width: double.infinity, // 使按钮宽度和下划线一样长
                      height: 20.w,
                      child: Text(
                        textAlign: TextAlign.center,
                        "帮助",
                        style: TextStyle(
                            color: Color(0xff333333), fontSize: 15.sp),
                      )),
                  SizedBox(height: 25.w,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: "alipay".png3x, width: 30.w,),
                      SizedBox(width: 25.w,),
                      Image(image: "wechat".png3x, width: 30.w,),
                    ],
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
