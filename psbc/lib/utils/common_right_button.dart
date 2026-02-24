import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/customer_service/customer_service_view.dart';
import 'package:psbc/pages/other/change_nav/change_nav_view.dart';
import 'package:psbc/routes/app_pages.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'scale_point_widget.dart';

/// 右边按钮类型枚举（基于项目中实际使用的按钮类型）
enum RightButtonType {
  /// 客服按钮 (home_right_khfw)
  customerService,
  
  /// 首页按钮 (right_tag1)
  home,
  
  /// 消息按钮 (home_left_msg)
  message,
  
  /// 添加按钮 (home_right_add)
  add,
  
  /// 更多按钮（弹出菜单，使用 ScalePointWidget）
  more,
  
  /// 退出按钮 (exit)
  exit,
  
  /// 分享按钮
  share,
  
  /// 搜索按钮
  search,
  
  /// 文本按钮
  text,
  
  /// 自定义按钮
  custom,
}

/// 右边按钮配置类
class RightButtonConfig {
  /// 按钮类型
  final RightButtonType type;
  
  /// 图标颜色
  final Color? iconColor;
  
  /// 点击回调
  final VoidCallback? onTap;
  
  /// 自定义图标路径（不带@3x后缀）
  final String? iconPath;
  
  /// 自定义图标尺寸
  final double? iconWidth;
  final double? iconHeight;
  
  /// 右边距
  final double? rightPadding;
  final double? leftPadding;
  
  /// 更多按钮特有：弹出内容
  final Widget? popupContent;
  final double? popupLeft;
  final double? popupDx;
  final double? popupDy;
  final double? popupWidth;
  
  /// 文本按钮特有：文本内容
  final String? text;
  final double? textFontSize;
  final Color? textColor;
  
  /// 自定义Widget（当type为custom时使用）
  final Widget? customWidget;
  
  /// 跳转路由名称
  final String? routeName;
  
  /// 跳转的页面Widget（用于 Get.to）
  final Widget Function()? pageWidget;
  
  /// 跳转参数（用于 Get.to）
  final dynamic arguments;

  RightButtonConfig({
    required this.type,
    this.iconColor,
    this.onTap,
    this.iconPath,
    this.iconWidth,
    this.iconHeight,
    this.rightPadding,
    this.leftPadding,
    this.popupContent,
    this.popupLeft,
    this.popupDx,
    this.popupDy,
    this.popupWidth,
    this.text,
    this.textFontSize,
    this.textColor,
    this.customWidget,
    this.routeName,
    this.pageWidget,
    this.arguments,
  });
}

/// 通用右边按钮构建器
class CommonRightButton {
  /// 根据配置列表构建右边按钮组（自动添加间距）
  static List<Widget> build(List<RightButtonConfig> configs, {
    double? leftSpacing,
    double? rightSpacing,
    double? betweenSpacing,
  }) {
    List<Widget> buttons = [];
    
    // 左侧间距
    if (leftSpacing != null || configs.isNotEmpty) {
      buttons.add(SizedBox(width: leftSpacing ?? 10.w));
    }
    
    // 构建按钮
    for (int i = 0; i < configs.length; i++) {
      Widget? button = _buildButton(configs[i]);
      if (button != null) {
        buttons.add(button);
        // 按钮之间的间距（最后一个按钮不加）
        if (i < configs.length - 1) {
          buttons.add(SizedBox(width: betweenSpacing ?? 12.w));
        }
      }
    }
    
    // 右侧间距
    if (rightSpacing != null || configs.isNotEmpty) {
      buttons.add(SizedBox(width: rightSpacing ?? 16.w));
    }
    
    return buttons;
  }

  /// 构建单个按钮
  static Widget? _buildButton(RightButtonConfig config) {
    switch (config.type) {
      case RightButtonType.customerService:
        return _buildCustomerServiceButton(config);
      case RightButtonType.home:
        return _buildHomeButton(config);
      case RightButtonType.message:
        return _buildMessageButton(config);
      case RightButtonType.add:
        return _buildAddButton(config);
      case RightButtonType.more:
        return _buildMoreButton(config);
      case RightButtonType.exit:
        return _buildExitButton(config);
      case RightButtonType.share:
        return _buildShareButton(config);
      case RightButtonType.search:
        return _buildSearchButton(config);
      case RightButtonType.text:
        return _buildTextButton(config);
      case RightButtonType.custom:
        return _buildCustomButton(config);
    }
  }

  /// 构建客服按钮 (home_right_khfw)
  /// 默认尺寸：37.w（标准）或 38.w（部分页面）
  static Widget _buildCustomerServiceButton(RightButtonConfig config) {
    return Image(
      image: (config.iconPath ?? 'home_right_khfw').png3x,
      width: config.iconWidth ?? 37.w,
      height: config.iconHeight ?? 37.w,
      color: config.iconColor,
    ).withOnTap(
      onTap: config.onTap ?? () {
        if (config.pageWidget != null) {
          if (config.arguments != null) {
            Get.to(config.pageWidget!, arguments: config.arguments);
          } else {
            Get.to(config.pageWidget!);
          }
        } else if (config.routeName != null) {
          Get.toNamed(config.routeName!);
        } else {
          Get.to(() => CustomerServicePage());
        }
      },
    );
  }

  /// 构建首页按钮 (right_tag1)
  /// 默认尺寸：22.w
  static Widget _buildHomeButton(RightButtonConfig config) {
    return Image(
      image: (config.iconPath ?? 'right_tag1').png3x,
      width: config.iconWidth ?? 22.w,
      height: config.iconHeight ?? 22.w,
      color: config.iconColor,
    ).withOnTap(
      onTap: config.onTap ?? () {
        if (config.routeName != null) {
          Get.toNamed(config.routeName!);
        } else {
          Get.offAllNamed(Routes.tabs);
        }
      },
    );
  }

  /// 构建消息按钮 (home_left_msg)
  /// 默认尺寸：22.w
  static Widget _buildMessageButton(RightButtonConfig config) {
    return Image(
      image: (config.iconPath ?? 'home_left_msg').png3x,
      width: config.iconWidth ?? 22.w,
      height: config.iconHeight ?? 22.w,
      color: config.iconColor,
    ).withOnTap(
      onTap: config.onTap ?? () {
        if (config.pageWidget != null) {
          if (config.arguments != null) {
            Get.to(config.pageWidget!, arguments: config.arguments);
          } else {
            Get.to(config.pageWidget!);
          }
        } else if (config.routeName != null) {
          Get.toNamed(config.routeName!);
        } else {
          Get.to(() => ChangeNavPage(),
              arguments: {'image': 'bg_msg', 'title': '消息'});
        }
      },
    );
  }

  /// 构建添加按钮 (home_right_add)
  /// 默认尺寸：20.w
  static Widget _buildAddButton(RightButtonConfig config) {
    return Image(
      image: (config.iconPath ?? 'home_right_add').png3x,
      width: config.iconWidth ?? 20.w,
      height: config.iconHeight ?? 20.w,
      color: config.iconColor,
    ).withOnTap(
      onTap: config.onTap ?? () {
        if (config.pageWidget != null) {
          if (config.arguments != null) {
            Get.to(config.pageWidget!, arguments: config.arguments);
          } else {
            Get.to(config.pageWidget!);
          }
        } else if (config.routeName != null) {
          Get.toNamed(config.routeName!);
        }
      },
    );
  }

  /// 构建更多按钮（弹出菜单，使用 ScalePointWidget）
  static Widget _buildMoreButton(RightButtonConfig config) {
    return ScalePointWidget(
      icColor: config.iconColor ?? Colors.black,
      icSize: config.iconWidth ?? 20.w,
      image: config.iconPath ?? 'home_right_add',
      content: config.popupContent,
      left: config.popupLeft,
      dx: config.popupDx ?? 50.w,
      dy: config.popupDy ?? 0.w,
      width: config.popupWidth ?? 140.w,
    );
  }

  /// 构建退出按钮 (exit)
  /// 默认尺寸：18.w
  static Widget _buildExitButton(RightButtonConfig config) {
    return Image(
      image: (config.iconPath ?? 'exit').png3x,
      width: config.iconWidth ?? 18.w,
      height: config.iconHeight ?? 18.w,
      color: config.iconColor,
    ).withOnTap(
      onTap: config.onTap ?? () {
        // 默认退出登录逻辑需要根据项目实际情况实现
        // 例如：''.saveToken; Get.offAll(() => LoginPage());
      },
    );
  }

  /// 构建分享按钮
  /// 默认尺寸：22.w
  static Widget _buildShareButton(RightButtonConfig config) {
    return Image(
      image: (config.iconPath ?? 'home_nav_share').png3x,
      width: config.iconWidth ?? 22.w,
      height: config.iconHeight ?? 22.w,
      color: config.iconColor,
    ).withOnTap(
      onTap: config.onTap ?? () {
        if (config.pageWidget != null) {
          if (config.arguments != null) {
            Get.to(config.pageWidget!, arguments: config.arguments);
          } else {
            Get.to(config.pageWidget!);
          }
        } else if (config.routeName != null) {
          Get.toNamed(config.routeName!);
        }
        // 默认分享逻辑需要根据项目实际情况实现
      },
    );
  }

  /// 构建搜索按钮
  /// 默认尺寸：22.w
  static Widget _buildSearchButton(RightButtonConfig config) {
    return Image(
      image: (config.iconPath ?? 'ic_search_left').png3x,
      width: config.iconWidth ?? 22.w,
      height: config.iconHeight ?? 22.w,
      color: config.iconColor,
    ).withOnTap(
      onTap: config.onTap ?? () {
        if (config.pageWidget != null) {
          if (config.arguments != null) {
            Get.to(config.pageWidget!, arguments: config.arguments);
          } else {
            Get.to(config.pageWidget!);
          }
        } else if (config.routeName != null) {
          Get.toNamed(config.routeName!);
        } else {
          // 默认跳转到搜索页面
          Get.toNamed('/search');
        }
      },
    );
  }

  /// 构建文本按钮
  static Widget _buildTextButton(RightButtonConfig config) {
    if (config.text == null) {
      return SizedBox.shrink();
    }
    
    return BaseText(
      text: config.text!,
      fontSize: config.textFontSize ?? 15,
      color: config.textColor ?? Colors.black,
    ).withContainer(
      padding: EdgeInsets.only(
        right: config.rightPadding ?? 12.w,
        left: config.leftPadding ?? 0,
      ),
      alignment: Alignment.center,
      onTap: config.onTap,
    );
  }

  /// 构建自定义按钮
  static Widget _buildCustomButton(RightButtonConfig config) {
    if (config.customWidget != null) {
      return config.customWidget!;
    }
    
    if (config.iconPath != null) {
      return Image(
        image: config.iconPath!.png3x,
        width: config.iconWidth ?? 24.w,
        height: config.iconHeight ?? 24.w,
        color: config.iconColor,
      ).withOnTap(
        onTap: config.onTap ?? () {
          if (config.pageWidget != null) {
            if (config.arguments != null) {
              Get.to(config.pageWidget!, arguments: config.arguments);
            } else {
              Get.to(config.pageWidget!);
            }
          } else if (config.routeName != null) {
            Get.toNamed(config.routeName!);
          }
        },
      );
    }
    
    return SizedBox.shrink();
  }
}
