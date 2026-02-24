import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../../../other/fixed_nav/fixed_nav_view.dart';

class DetailWidget4 extends StatefulWidget {
  const DetailWidget4({super.key});

  @override
  State<DetailWidget4> createState() => _DetailWidget4State();
}

class _DetailWidget4State extends State<DetailWidget4> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'zhxq_bg3'.png3x).withOnTap(onTap: (){
          Get.to(() => FixedNavPage(),arguments: {
            'image':'yjbk',
            'title':'一键绑卡'
          });
        }),
      ],
    );
  }
}
