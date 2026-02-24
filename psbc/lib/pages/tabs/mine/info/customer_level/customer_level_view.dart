import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../component/right_widget.dart';

class CustomerLevelPage extends BaseStateless {
  CustomerLevelPage({Key? key}) : super(key: key, title: '客户等级');

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Widget initBody(BuildContext context) {
    final memberInfo = AppConfig.config.abcLogic.memberInfo;
    
    return Stack(
      children: [
        // 背景图片
        Image(
          image: 'khdj'.png3x,
          width: 1.sw,
          fit: BoxFit.fitWidth,
        ),
        
        // 信息内容
        Positioned(
          top: 10.w,
          right: 15.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 50.w),
                  child: _buildInfoRow('账号', _formatCardNumber(AppConfig.config.abcLogic.card1()))),
              SizedBox(height: 35.w),
              _buildInfoRow('姓名', memberInfo.realName.isNotEmpty ? memberInfo.realName : '张三'),
              SizedBox(height: 32.w),
              _buildInfoRow('性别', _getGenderText(memberInfo.sex)),
              SizedBox(height: 75.w),
              _buildInfoRow('I类', 'I类'),
              SizedBox(height: 80.w),
              _buildInfoRow('账户卡号', _formatCardNumber(AppConfig.config.abcLogic.card1())),
              SizedBox(height: 34.w),
              _buildInfoRow('附加账号', _formatCardNumber(AppConfig.config.abcLogic.card1())),
            ],
          ),
        ),
      ],
    );
  }

  // 获取性别文本
  String _getGenderText(String sex) {
    if (sex.isEmpty) return '男';
    // 如果sex是1/2这样的数字，进行转换
    if (sex == '1' || sex.toLowerCase() == 'male' || sex == '男') return '男';
    if (sex == '2' || sex.toLowerCase() == 'female' || sex == '女') return '女';
    return sex; // 如果已经是中文直接返回
  }

  // 格式化卡号为 6217 99 ********* 8181
  String _formatCardNumber(String cardNumber) {
    if (cardNumber.length < 10) return cardNumber;
    
    String first4 = cardNumber.substring(0, 4);
    String next2 = cardNumber.substring(4, 6);
    String last4 = cardNumber.substring(cardNumber.length - 4);
    
    return '$first4 $next2 ********* $last4';
  }

  Widget _buildInfoRow(String label, String value) {
    return BaseText(
      text: value,
      fontSize: 14.w,
      color: Color(0xFF333335),
    );
  }
}
