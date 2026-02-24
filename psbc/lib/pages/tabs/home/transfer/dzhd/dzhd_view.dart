import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/transfer/dzhd/dzhd_list/dzhd_list_view.dart';
import 'package:psbc/pages/tabs/home/transfer/dzhd/dzhd_list/dzhd_verification/dzhd_verification_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../component/right_widget.dart';
import 'dzhd_logic.dart';
import 'dzhd_state.dart';

class DzhdPage extends BaseStateless {
  DzhdPage({Key? key}) : super(key: key,title: '电子回单');

  final DzhdLogic logic = Get.put(DzhdLogic());
  final DzhdState state = Get.find<DzhdLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();
  
  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: 'dzhd'.png3x),
            
            Positioned(child: Container(
              child: Column(
                children: [
                  Container(
                    width: 1.sw,
                    height: 45.w,
                  ).withOnTap(onTap: (){
                    Get.to(()=>Dzhd_listPage());
                  }),
                  Container(
                      width: 1.sw,
                      height: 45.w,
                  ).withOnTap(onTap: (){
                    Get.to(() => DzhdVerificationPage());
                  }),
                ],
              ),
            ))
          ],
        )
      ],
    );
  }
}
