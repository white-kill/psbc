import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/app_config.dart';
import 'main/my_app_page.dart';

void main() async{
  // 确保 Flutter 绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();
  
  // 设置样式 - 必须在 initApp 之前，避免被覆盖
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // 底部导航栏颜色
      systemNavigationBarDividerColor: Colors.transparent, // 底部导航栏分割线颜色
      systemNavigationBarIconBrightness: Brightness.dark, // 底部导航栏图标颜色
      statusBarColor: Colors.transparent, // 状态栏颜色
      statusBarBrightness: Brightness.dark, // 状态栏图标和文字的颜色
    ),
  );
  await AppConfig.config.initApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });

}

